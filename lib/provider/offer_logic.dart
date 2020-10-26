import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:flutter/material.dart';

class OfferLogic extends ChangeNotifier {
//internal used offer
  Offer _offer;

  ///Returns the currently selected offer.
  ///Migth be null when no offer is selected.
  Offer get offer => _offer;

  ///Set the selected offer.
  set setOffer(Offer offer) {
    _offer = offer;
    //update ui
    notifyListeners();
  }

//internal list of offer
  List<Offer> _offers = [];

  ///Returns the list of available offers.
  ///It loads them from a server via REST api.
  Future<List<Offer>> get offers async {
    //return offers
    return await ApiClient.getOffers();
  }
}
