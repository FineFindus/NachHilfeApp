import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/screens/onboarding.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../main.dart';

class ApiClient {
  ///API url from the server to post and get offers
  static final String baseUrl = "https://discite-server.herokuapp.com";

  static final String apiOfferUrl = "$baseUrl/offer";

  ///The API url for the user
  ///Used to register the user at the server and used in offer post request.
  static final String apiUserURL = "$baseUrl/user";

  ///Creates a GET request to the server to get the offers from the database.
  ///Throws an exception if something failed.
  static Future<List<dynamic>> getOffers(
      {bool withCache = true, bool isAccepted = false}) async {
    //String urlWithQuery = "$url?accepted=${isAccepted.toString()}";
    //TODO add query
    String urlWithQuery = "$apiOfferUrl";

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
      } else
        return Future.error(response.statusCode);
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        //the accessToken is invalid, try to refresh and get new token
        await refreshToken().onError(
            (error, stackTrace) => Future.error(e.response.statusCode));
        return await getOffers();
      } else
        return Future.error(e.response.statusCode);
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
      response = await dio.post(apiOfferUrl, data: offer.toJson());

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
      return Future.error(
          e.response.statusCode, StackTrace.fromString(e.toString()));
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
    String apiURL = "$apiOfferUrl/${offer.id}";

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
          e.response.statusCode, StackTrace.fromString(e.toString()));
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
        // await login(userId, 100000);
      } else if (response.statusCode == 409) {
        //user already exist, send sign in
        return Future.error(
          409,
        );
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

  static Future<void> refreshToken() async {
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
      //getemail code

      //show login screen
      navigatorKey.currentState
          .push(MaterialPageRoute(builder: (context) => EmailPinScreen()));
      return Future.error("Login failed");
    }
  }
}
