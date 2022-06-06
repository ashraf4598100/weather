import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failures.dart';

import 'package:weather/features/weather_details/domain/repositroy/weather_repository.dart';

import '../../data_source/model/weather_details_response_model.dart';

abstract class WeatherDetailsUseCase {
  Future<Either<Failure,WeatherResponseModel>> weatherUseCase ();
}

class WeatherDetailsUseCaseImp implements WeatherDetailsUseCase{
  final WeatherRepository weatherRepository;

  WeatherDetailsUseCaseImp(this.weatherRepository);
  
  @override
  Future<Either<Failure, WeatherResponseModel>> weatherUseCase() async {
   return await weatherRepository.weatherRepository();
  }
}