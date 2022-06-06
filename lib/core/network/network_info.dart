



import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInf {
  final String baseUrl = "https://api.openweathermap.org";
  Future<bool> get isConnected;
}

class NetworkInfImpl implements NetworkInf {
  final String baseurl = "https://api.openweathermap.org";

  // final String url = "https://fakestoreapi.com/products?limit=";
   final Connectivity? connectionChecker;

  NetworkInfImpl([
    this.connectionChecker,
  ]);
 @override
  Future<bool> get isConnected async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  @override
  String get baseUrl => baseurl.toString();
}
