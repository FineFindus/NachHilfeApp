import 'package:NachHilfeApp/model/offer.dart';
import 'package:flutter/material.dart';

class OfferLogic extends ChangeNotifier {
//internal list of offer
  List<Offer> _offers = [];

  ///Returns the list of availeble offers.
  List<Offer> get offers {}
}
