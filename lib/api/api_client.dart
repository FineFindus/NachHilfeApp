import 'dart:convert';

import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:NachHilfeApp/utils/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class ApiClient {
  static final String url =
      "https://my-json-server.typicode.com/finefindus/nachhilfeapp-json-demo/db";

  ///Creates a GET request to the server to get the offers from the database.
  ///Throws an exception if something failed.
  static Future<List<dynamic>> getOffers() async {
    Response response;
    //create dio for http request
    Dio dio = new Dio();
    //set options like timeout, etc.
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000; //10s

    //create cache
    dio.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor);

    //get response from server with cache
    try {
      //get data
      response =
          await dio.get(url, options: buildCacheOptions(Duration(hours: 8)));

      //check the status code
      if (response.statusCode == 200 && response.data != null) {
        //request was successful
        List<Offer> responseData = [];

        //map data to list
        Map<String, dynamic> map = response.data;
        List<dynamic> data = map["offers"];

        //add data to list
        for (var i = 0; i < data.length; i++) {
          responseData.add(Offer.fromMap(data[i]));
        }
        //return data
        return responseData;
      } else if (response.statusCode == 404) {
        //user could not reach server
        return Future.error("The user is offline, a 404 error was returned",
            StackTrace.fromString("This is its trace"));
      } else {
        //user was not reached
        return Future.error("The Server could not be reached",
            StackTrace.fromString("This is its trace"));
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT) print("Test");
      print(e);
      return Future.error(
          "An error occured", StackTrace.fromString(e.toString()));
    }
  }

  static Future<void> updateOffer(Offer offer) async {
    //check if id is null
    if (offer.id == null || offer.id <= 0)
      return Future.error("Id must not be null/larger than 0");
    //TODO put update
    String apiURL = "$url/${offer.id}";
  }
}
