import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:flutter/material.dart';

class OfferLogic extends ChangeNotifier {
  //internal used offer
  Offer? _offer;

  //If the user is logged in
  bool _userLoggedIn = false;

  ///Returns the length of the available offers
  int get length => _offers?.length ?? 0;

  ///Returns the currently selected offer.
  ///Might be null when no offer is selected.
  Offer? get offer => _offer;

  ///Returns if the user is logged in.
  bool get isLoggedIn => _userLoggedIn;

  ///Set the selected offer.
  set setOffer(Offer offer) {
    //check if old and new offer are the same
    if (_offer == offer) return;
    //set offer
    _offer = offer;
    //update ui
    notifyListeners();
  }

  ///Set if the user is logged in.
  set isLoggedIn(bool loggedIn) {
    _userLoggedIn = loggedIn;
    //send update
    notifyListeners();
  }

  //internal list of offer
  List<Offer>? _offers;

  ///Returns the list of available offers.
  ///It loads them from a server via REST api.
  ///Returns an empty list if the user is not logged in.
  Future<List<Offer>> get offers async {
    //dont get offers if the user is not yet logged in.
    if (!_userLoggedIn) return [];

    //return offers if not null
    if (_offers != null) {
      return _offers!;
    }

    //load offer
    _offers = await ApiClient.getOffers();

    //else load the offers from he server
    if (_offers != null) {
      return _offers!;
    }
    return [];
  }

  ///Removes a offer from the internal list of offers without refreshing them
  ///from the server.
  void removeOffer(Offer offer) {
    if (_offers != null) {
      _offers!.remove(offer);
    }
    notifyListeners();
  }

  ///Refresh the offer list by loading
  Future<void> refreshOffers() async {
    //load new offers from server via apiClient
    _offers = await (ApiClient.getOffers(
      withCache: false,
    ));
    //update ui
    notifyListeners();
  }
}
