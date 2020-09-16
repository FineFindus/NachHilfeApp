import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/utils/exceptions.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final String url =
      'https://my-json-server.typicode.com/finefindus/nachhilfeapp-json-demo/offers';

  ///Creates a GET request to the server to get the offers from the database.
  ///Throws an exception if something failed.
  static Future<List<Offer>> getOffers() async {
    Response response;
    Dio dio = new Dio();
    //get response from server
    response = await dio.get(url);

    //check the status code
    if (response.statusCode == 200 && response.data != null) {
      //request was successful
      List<Offer> responseData = [];
      //add data to list
      for (var i = 0; i < response.data.length; i++) {
        responseData.add(Offer.fromMap(response.data[i]));
      }
      //return the list
      return responseData;
    } else if (response.statusCode == 404) {
      //user could not reach server
      throw StatusCode4Exception();
    } else {
      //user was not reached
      throw ServerException();
    }
  }
}
