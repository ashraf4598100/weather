

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/features/weather_details/data_source/remote_data/weather_details_remote_data.dart';
import 'package:weather/features/weather_details/data_source/repository/weather_repository_imp.dart';
import 'package:weather/features/weather_details/domain/repositroy/weather_repository.dart';
import 'package:weather/features/weather_details/domain/usecase/weather_details_use_case.dart';
import 'package:weather/features/weather_details/presentation/bloc/weather_bloc.dart';

import 'core/network/network_info.dart';
import 'core/remote_data_function/http_methods.dart';
import 'package:http/http.dart' as http;
final sl = GetIt.instance;

Future<void> init() async {
  
  // Bloc
  sl.registerFactory(
    () => WeatherBloc(
      sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<WeatherDetailsUseCase>(
    () => WeatherDetailsUseCaseImp(
      sl(),

    ));
  // Repository

  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImp(
      sl(),
      sl(),
    ),
  ); 



 

  // Data sources



    sl.registerLazySingleton<WeatherDetailsRemoteData>(
    () => WeatherDetailsRemoteDataImp(sl(), sl()),
  );

  
  //! Core
  sl.registerLazySingleton<NetworkInf>(() => NetworkInfImpl(sl()));

  sl.registerLazySingleton<NetworkFunctions>(
    () => NetworkFunctionsImp(sl()),
  );
  

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
