part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}



class GetWeatherDetailsEvent extends WeatherEvent {
  final DateTime chosedDate;


  const GetWeatherDetailsEvent( this.chosedDate,);
}