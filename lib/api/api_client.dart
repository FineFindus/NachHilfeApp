import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/utils/exceptions.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final String url = 'https://jsonplaceholder.typicode.com/photos';

  ///Creates a GET request to the server to get the offers from the database.
  ///Throws an exception if something failed.
  static Future<List<Offer>> getOffers() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(url);
    //check for status code
    if (response.statusCode == 200 && response.data != null) {
      //request was successful
      print(response.data.toString());
      //user could not reach server
    } else if (response.statusCode == 404) {
      throw StatusCode4Exception();
    } else {
      throw ServerException();
    }
  }
}
