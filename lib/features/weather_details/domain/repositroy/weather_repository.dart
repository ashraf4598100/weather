import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failures.dart';

import '../../data_source/model/weather_details_response_model.dart';






abstract class WeatherRepository {
  Future<Either<Failure,WeatherResponseModel>> weatherRepository();
}