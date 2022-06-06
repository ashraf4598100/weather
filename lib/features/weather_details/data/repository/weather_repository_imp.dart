
import 'package:weather/core/network/network_info.dart';

import 'package:weather/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather/features/weather_details/data_source/model/weather_details_response_model.dart';
import 'package:weather/features/weather_details/data_source/remote_data/weather_details_remote_data.dart';

import 'package:weather/features/weather_details/domain/repositroy/weather_repository.dart';





class WeatherRepositoryImp implements WeatherRepository {
  final NetworkInf networkInf;
  final WeatherDetailsRemoteData weatherDetailsRemoteData;

  WeatherRepositoryImp(this.networkInf, this.weatherDetailsRemoteData);
  @override
  Future<Either<Failure, WeatherResponseModel>> weatherRepository() async {
    if (await networkInf.isConnected) {
      // try {
        final result = await weatherDetailsRemoteData.getWeatherDetails();

        return Right((result));
      // } catch (e) {
      //   if (e is AppException) {
      //     var error = e.message;

      //     return Left(ServerFailure(error));
      //   } else {
      //     return const Left(ServerFailure("server failure"));
      //   }
      // }
    } else {
      return const Left(NetWorkFailure('check internet connection'));
    }
  }
}
