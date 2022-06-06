import 'package:weather/core/network/network_info.dart';
import 'package:weather/core/remote_data_function/http_methods.dart';

import '../../data_source/model/weather_details_response_model.dart';




abstract class WeatherDetailsRemoteData {
  Future<dynamic> getWeatherDetails();
}


class WeatherDetailsRemoteDataImp implements WeatherDetailsRemoteData{
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  WeatherDetailsRemoteDataImp(this.networkFunctions, this.networkInf);
  
  @override
  Future getWeatherDetails() async {
    var response = await networkFunctions.getMethod(url: "/data/2.5/forecast?id=292223&appid=af3784e5d6b10233303d7afdbb7b4c5a",baseurl: networkInf.baseUrl);

    return weatherResponseModelFromJson(response);
  }
}