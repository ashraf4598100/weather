import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:weather/core/exceptions/app_excepition.dart';

abstract class NetworkFunctions {
  Future<dynamic> getMethod({String url, String baseurl});
  Future<dynamic> postMethod({String url, String baseurl, dynamic body});
}

class NetworkFunctionsImp implements NetworkFunctions {
 final http.Client client ;

  NetworkFunctionsImp(this.client);
  @override
  Future<dynamic> getMethod({String? url, String ?baseurl}) async {

    final response = await client.get(
      Uri.parse(baseurl! + url!),
      headers: {
        'Content-Type': 'application/json',
            
      },
    );
    log(baseurl + url);
    log(response.body);
    if (response.statusCode == 200) {
      log("200");
      return response.body;
    }
  else  if (response.statusCode == 500) {
      var res = json.decode(response.body);
      log(res);
      log("Sorry Internal Server Error");
      throw InternalServerError( );
    } 
     if (response.statusCode == 400) {
    
    
      throw BadRequestException("Sorry Bad Request");
    } 

    else {
      throw InternalServerError("Sorry Internal Server Error");
    }
  }

  @override
  Future postMethod({String ? url, String ?baseurl, body}) async {
    final response = await client.post(Uri.parse(baseurl! + url!),
        headers: {
          'Content-Type': 'application/json',

        },
        body: body );
    log(baseurl + url);
    log(response.body);

     if (response.statusCode == 200) {
      log("200");
      return response.body;
    }
  else  if (response.statusCode == 500) {
      var res = json.decode(response.body);
      log(res);
      log("Sorry Internal Server Error");
      throw InternalServerError( );
    } 
     if (response.statusCode == 400) {
    
    
      throw BadRequestException("Sorry Bad Request");
    } 

    else {
      throw InternalServerError("Sorry Internal Server Error");
    }
  }
}
