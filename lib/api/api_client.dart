import 'dart:io';

import 'package:NachHilfeApp/model/offer.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class ApiClient {
  ///API url from the server to post and get offers
  static final String url =
      // "http://10.10.8.218:8888/api/v1/offers";
      //test link
      "https://my-json-server.typicode.com/finefindus/nachhilfeapp-json-demo/offers";

  //ip address
  //10.10.8.218
  //network name : ITCDisciteSrv

  //TODO: update url
  ///The API url for the user
  ///Used to register the user at the server and used in offer post request.
  static final String apiUserURL = "https://google.com";

  //TODO change to real url should be something/ api/v1/offers

  ///Creates a GET request to the server to get the offers from the database.
  ///Throws an exception if something failed.
  static Future<List<dynamic>> getOffers(
      {bool withCache = true, bool isAccepted = false}) async {
    String urlWithQuery = "$url?accepted=${isAccepted.toString()}";

    Response response;
    //create dio for http request
    Dio dio = new Dio();
    //set options like timeout, etc.
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000; //10s

    //create cache
    if (withCache)
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: urlWithQuery)).interceptor);

    //allow http traffic for debug on localhost
    // if (kDebugMode)
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    //get response from server with cache
    try {
      //get data
      if (withCache)
        response = await dio.get(urlWithQuery,
            options: buildCacheOptions(Duration(hours: 8)));
      else
        response = await dio.get(urlWithQuery);

      //check the status code
      if (response.statusCode == 200 && response.data != null) {
        //request was successful
        List<Offer> responseData = [];

        print(response.data.toString());

        /*
        //! use if data comes as list example:
        //! {"offers": [{data}]} 
        //map data to list
        Map<String, dynamic> map = response.data;
        List<dynamic> data = map["offers"];

        //add data to list
        for (var i = 0; i < data.length; i++) {
          responseData.add(Offer.fromMap(data[i]));
        } 
        
        //return data
        return responseData; */

        //add data to list
        for (var i = 0; i < response.data.length; i++) {
          responseData.add(Offer.fromMap(response.data[i]));
        }
        //return the list
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
      print(e);
      return Future.error(
          "An error occurred", StackTrace.fromString(e.toString()));
    }
  }

  static Future<void> postOffer(Offer offer) async {
    assert(offer != null && offer.userMail != null);

    // post to server

    //response
    Response response;
    //create dio for http request
    Dio dio = new Dio();
    //set options like timeout, etc.
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000; //10s

    try {
      //post data
      response = await dio.post(url, data: offer.toJson());

      print(response);

      //check the status code
      if (response.statusCode == 200 && response.data != null) {
        //offer was accepted and is returned with a id
      } else if (response.statusCode == 404) {
        //the user is offline or the id could not be found and a 404 was returned
        return Future.error(
            "The user is offline or the id could not be found and a 404 was returned",
            StackTrace.fromString("This is its trace"));
      }
    } on DioError catch (e) {
      //catch errors
      print(e);
      return Future.error(
          "An error occurred: $e", StackTrace.fromString(e.toString()));
    }
  }

  ///PUT operation to update a already existing offer on the server.
  ///The id cannot be null and must be larger than 0.
  static Future<void> updateOffer(Offer offer) async {
    //check if id is null
    if (offer.id == null || offer.id <= 0)
      return Future.error("Id must not be null/larger than 0");
    //put update

    //url for the specific offer per id. The id parameter can only be a number
    String apiURL = "$url/${offer.id}";

    Response response;
    //create dio for http request
    Dio dio = new Dio();
    //set options like timeout, etc.
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000; //10s

    try {
      //put data
      response = await dio.put(apiURL, data: offer.toJson());

      //check the status code
      if (response.statusCode == 200 && response.data != null) {
        //maybe do something with the response?
      } else {
        //the user is offline or the id could not be found and a 404 was returned
        return Future.error(
            "The user is offline or the id could not be found and a 404 was returned",
            StackTrace.fromString("This is its trace"));
      }
    } on DioError catch (e) {
      //catch errors
      print(e);
      return Future.error(
          "An error occurred", StackTrace.fromString(e.toString()));
    }
  }

  ///POST the userMail and fcmToken to the server to create a user.
  ///This might be used for OAuth with the server.
  ///The fcmToken will be used to send push notification to the device.
  static Future<void> registerUserWithToken(
      String userMail, String fcmToken) async {
    Response response;
    //create dio for http request
    Dio dio = new Dio();
    //set options like timeout, etc.
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000; //30s

    try {
      //post data to server
      //TODO register user
      // response = await dio.post(apiUserURL);

      //check the status code
      if (response.statusCode == 200 && response.data != null) {
        //TODO: im currently unsure what the response looks like, maybe a user id?
        //TODO: possible a returned OAuth 2.0 key, to identify in further get request?

      } else if (response.statusCode == 404) {
        //check if the user is offline
        return Future.error(
            "A StatusCode 404 was returned, this indicates that the user might be offline",
            StackTrace.fromString("This is its trace"));
      }
    } catch (e) {}
  }
}
