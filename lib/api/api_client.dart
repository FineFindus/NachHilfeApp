import 'package:NachHilfeApp/model/offer.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class ApiClient {
  static final String url =
      "https://my-json-server.typicode.com/finefindus/nachhilfeapp-json-demo/db";

  static final String apiUserURL = "TODO: insert url";

  ///TODO change to real url should be something/ api/v1/offers

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

        //responseData..shuffle();
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

  ///PUT operation to update a already existing offer on the server.
  ///The id cannot be null and must be larger than 0.
  static Future<void> updateOffer(Offer offer) async {
    print(offer);
    //check if id is null
    if (offer.id == null || offer.id <= 0)
      return Future.error("Id must not be null/larger than 0");
    //TODO put update
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
        //TODO

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
          "An error occured", StackTrace.fromString(e.toString()));
    }
  }

  ///POST the userMail and fcmToken to the server to create a user.
  ///This might be used for OAuth with the server.
  ///The fcmToken will be used to send push notfication to the device.
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
      response = await dio.post(apiUserURL);

      //check the status code
      if (response.statusCode == 200 && response.data != null) {
        //TODO: im currently unsure what the response lokks like, maybee a user id?
        //TODO: possible a returned OAuth 2.0 key, to indetify in further get request?

      } else if (response.statusCode == 404) {
        //check if the user is offline
        return Future.error(
            "A StatusCode 404 was returned, this indicates that the user migth be offline",
            StackTrace.fromString("This is its trace"));
      }
    } catch (e) {}
  }
}
