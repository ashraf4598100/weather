part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}


class GetWeatherDetailsState extends WeatherState {
  final WeatherInfo weatherInfo;

 const GetWeatherDetailsState(this.weatherInfo);
}

class Loading extends WeatherState{}

class Error extends WeatherState{
  final String error;

  const Error(this.error);
}