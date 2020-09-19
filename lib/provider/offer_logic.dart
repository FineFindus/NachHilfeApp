import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:flutter/material.dart';

class OfferLogic extends ChangeNotifier {
//internal list of offer
  List<Offer> _offers = [];

  ///Returns the list of available offers.
  ///It loads them from a server via REST api.
  Future<List<Offer>> get offers async {
    //return offers
    return await ApiClient.getOffers();
  }
}
