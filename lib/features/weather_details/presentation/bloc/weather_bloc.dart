import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/features/weather_details/data_source/model/weather_details_response_model.dart';
import 'package:weather/features/weather_details/domain/usecase/weather_details_use_case.dart';
import '../../../../injection_container.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherDetailsUseCase weatherDetailsUseCase;
  WeatherBloc(this.weatherDetailsUseCase) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      String? weather;
      DateTime? cashedDate;
      if (event is GetWeatherDetailsEvent) {
        bool isFirstTime = checkIfFirstTime();
        if (isFirstTime == false) {                                 ///////check for the first Time Connection
          weather = sl<SharedPreferences>().getString('weather');
          if (weather != null) {                                    /////// check if there is a problem with cashed weather
            cashedDate = getCashedDate();
            if (compareCachedDateWithCurrentDate(cashedDate)) {           /// check if the request in the same day
              final weatherResponseModel = getCachedWeather(weather);
              final weatherInfo = getWeatherDetailsForSpecificDay(
                  weatherResponseModel.list!, event.chosedDate);
              emit(GetWeatherDetailsState((weatherInfo)));
            } else {                                                            //// request not in the same day
              emit(Loading());
              setCachedDate(DateTime.now());
              var response = await weatherDetailsUseCase.weatherUseCase();
              response.fold((l) => emit(Error(l.error!)), (r) {
                cacheWeather(r);
                final weatherInfo =
                    getWeatherDetailsForSpecificDay(r.list!, event.chosedDate);
                emit(GetWeatherDetailsState(weatherInfo));
              });
            }
          } else {                                                              ///there is a problem with cached data
            emit(Loading());
            var response = await weatherDetailsUseCase.weatherUseCase();
            response.fold((l) => emit(Error(l.error!)), (r) {
              cacheWeather(r);
              final weatherInfo =
                  getWeatherDetailsForSpecificDay(r.list!, event.chosedDate);
              emit(GetWeatherDetailsState(weatherInfo));
              setCachedDate(DateTime.now());
            });
          }
        } else {                                                                    // first time connection
          emit(Loading());
          var response = await weatherDetailsUseCase.weatherUseCase();
          response.fold((l) => emit(Error(l.error!)), (r) {
            cacheWeather(r);
            final weatherInfo =
                getWeatherDetailsForSpecificDay(r.list!, event.chosedDate);
            emit(GetWeatherDetailsState(weatherInfo));
            setCachedDate(DateTime.now());
          });
        }
      }
    });
  }
}

getWeatherDetailsForSpecificDay(List<WeatherInfo> list, DateTime chosedDate) {
  WeatherInfo weatherInfo = list.firstWhere(
    (element) =>
        element.dtTxt.toString().substring(0, 10) ==
        chosedDate.toString().substring(0, 10),
    orElse: () => WeatherInfo(),
  );

  return weatherInfo;
}

setCachedDate(DateTime dateTime) {
  sl<SharedPreferences>().setString(
    "CurrentDate",
    DateTime.now().toIso8601String(),
  );
}

DateTime getCashedDate() {
  return DateTime.parse(sl<SharedPreferences>().get("CurrentDate").toString());
}

cacheWeather(WeatherResponseModel weatherResponseModel) {
  sl<SharedPreferences>()
      .setString("weather", json.encode(weatherResponseModel));
}

bool compareCachedDateWithCurrentDate(DateTime cashedDate) {
  if (cashedDate.toString().substring(0, 10) ==
      DateTime.now().toString().substring(0, 10)) {
    return true;
  } else {
    return false;
  }
}

bool checkIfFirstTime() {
  if (sl<SharedPreferences>().getString("CurrentDate") == null) {
    setCachedDate(DateTime.now());
    return true;
  } else {
    return false;
  }
}

WeatherResponseModel getCachedWeather(String weather) {
  Map<String, dynamic>? cachedWeather =
      jsonDecode(weather.toString()) as Map<String, dynamic>;
  WeatherResponseModel weatherResponseModel =
      WeatherResponseModel.fromJson(cachedWeather);

  return weatherResponseModel;
}
