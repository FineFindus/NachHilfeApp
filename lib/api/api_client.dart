import 'dart:io';

import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/screens/onboarding.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  ///API url from the server to post and get offers
  static final String url =
      // "http://10.10.8.218:8888/api/v1/offers";
      //test link
//      "http://10.0.2.2:3000/offer";
      "http://10.10.2.140:3000/offer";

  // "https://my-json-server.typicode.com/finefindus/nachhilfeapp-json-demo/offers";

  //TODO: update url
  ///The API url for the user
  ///Used to register the user at the server and used in offer post request.
  static final String apiUserURL =
//  "http://10.0.2.2:3000/user";
      "http://10.10.2.140:3000/user";

  //TODO change to real url should be something/ api/v1/offers

  ///Creates a GET request to the server to get the offers from the database.
  ///Throws an exception if something failed.
  static Future<List<dynamic>> getOffers(
      {BuildContext context,
      bool withCache = true,
      bool isAccepted = false}) async {
    // String urlWithQuery = "$url?accepted=${isAccepted.toString()}";
    //TODO add query
    String urlWithQuery = "$url";

    Response response;
    //create dio for http request
    Dio dio = new Dio();
    //set options like timeout, etc.
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000; //10s

    //add auth header
    //get accessToken
    final String accessToken =
        await FlutterSecureStorage().read(key: "accessToken");
    dio.options.headers["authorization"] = "Bearer $accessToken";
    print("token:$accessToken");

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

        //map data to list
        List<dynamic> data = response.data["offers"];

        //add data to list
        for (var i = 0; i < data.length; i++) {
          final Offer offer = Offer.fromMap(data[i]);
          // only add offers that are not accepted
          if (!offer.isAccepted) responseData.add(offer);
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
      if (e.type == DioErrorType.RESPONSE)
      // && e.message.trim() ==
      //         "DioError [DioErrorType.RESPONSE]: Http status error [401]"
      //             .trim())
      {
        await refreshToken(context);
        print("asjkdhjjjjj");
        // return await getOffers();
      }
      print("Error: $e");
      return Future.error(
          "An error occurred: $e", StackTrace.fromString(e.toString()));
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
    //add auth header
    //get accessToken
    final String accessToken =
        await FlutterSecureStorage().read(key: "accessToken");
    dio.options.headers["authorization"] = "Bearer $accessToken";

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
    if (offer.id == null)
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
    //get accessToken
    final String accessToken =
        await FlutterSecureStorage().read(key: "accessToken");
    //add auth header
    dio.options.headers["authorization"] = "Bearer $accessToken";

    try {
      //put data
      response = await dio.put(apiURL, data: offer.toJson());

      //check the status code
      if (response.statusCode == 201 && response.data != null) {
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
    assert(userMail != null);
    Response response;
    //create dio for http request
    Dio dio = new Dio();
    //set options like timeout, etc.
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000; //30s

    try {
      //post data to server
      //TODO register user
      response = await dio.post("$apiUserURL/signup", data: {
        "email": userMail,
        fcmToken != null && fcmToken.isNotEmpty ? "pushMessageToken" : fcmToken:
            null
      });

      //check the status code
      if (response.statusCode == 201 && response.data != null) {
        //get user id
        final userId = response.data["user"]["_id"];
        //save id to secure storage
        final FlutterSecureStorage secureStorage = FlutterSecureStorage();
        await secureStorage.write(key: "user_id", value: userId.toString());
        await login(userId, 100000);
      } else if (response.statusCode == 404) {
        //check if the user is offline
        return Future.error(
            "A StatusCode 404 was returned, this indicates that the user might be offline",
            StackTrace.fromString("This is its trace"));
      }
    } catch (e) {}
  }

  static Future<void> login(String id, int emailCode) async {
    assert(id != null && emailCode != null);
    Response response;
    //create dio for http request
    Dio dio = new Dio();
    //set options like timeout, etc.
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000; //30s

    try {
      //post data to server
      //TODO register user
      response = await dio.post("$apiUserURL/login/$id", data: {
        "emailCode": emailCode,
      });

      //check the status code
      if (response.statusCode == 200 && response.data != null) {
        //get tokens
        final accessToken = response.data["accessToken"];
        final refreshToken = response.data["refreshToken"];

        //save save tokens
        final FlutterSecureStorage secureStorage = FlutterSecureStorage();
        await secureStorage.write(
            key: "accessToken", value: accessToken.toString());
        await secureStorage.write(
            key: "refreshToken", value: refreshToken.toString());
      } else if (response.statusCode == 404) {
        //check if the user is offline
        return Future.error(
            "A StatusCode 404 was returned, this indicates that the user might be offline",
            StackTrace.fromString("This is its trace"));
      }
    } catch (e) {}
  }

  static Future<void> refreshToken(BuildContext context) async {
    Response response;
    //create dio for http request
    Dio dio = new Dio();
    //set options like timeout, etc.
    dio.options.connectTimeout = 30000; //30s
    dio.options.receiveTimeout = 30000; //30s

    //get user id
    final String userId = await FlutterSecureStorage().read(key: "user_id");

    //get refreshToken
    final String refreshToken =
        await FlutterSecureStorage().read(key: "refreshToken");
    dio.options.headers["authorization"] = "Bearer $refreshToken";

    try {
      //post data to server
      //TODO register user
      response = await dio.get("$apiUserURL/refreshToken/$userId");

      //check the status code
      print(response.data);
      if (response.statusCode == 200 && response.data != null) {
        //get tokens
        final accessToken = response.data["accessToken"];
        final refreshToken = response.data["refreshToken"];

        //save save tokens
        final FlutterSecureStorage secureStorage = FlutterSecureStorage();
        await secureStorage.write(
            key: "accessToken", value: accessToken.toString());
        await secureStorage.write(
            key: "refreshToken", value: refreshToken.toString());
      } else if (response.statusCode == 404) {
        //check if the user is offline
        return Future.error(
            "A StatusCode 404 was returned, this indicates that the user might be offline",
            StackTrace.fromString("This is its trace"));
      }
    } catch (e) {
      print("error when loading refresh tokens");
      //show login screen
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OnboardingScreen()));
    }
  }
}
