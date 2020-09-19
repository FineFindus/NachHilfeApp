import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:flutter/material.dart';

class OfferLogic extends ChangeNotifier {
//internal list of offer
  List<Offer> _offers = [];

  ///Returns the list of availeble offers.
  Future<List<Offer>> get offers async {
    return await ApiClient.getOffers();
  }
}
