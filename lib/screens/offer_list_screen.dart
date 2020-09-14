import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/screens/screens.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:NachHilfeApp/widgets/widgets.dart';
import 'package:animations/animations.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class OfferListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //get offers
    var offers = Provider.of<OfferLogic>(context).offers;

    return Scaffold(
      appBar: AppBar(
        title: Text("Angebote"),
        centerTitle: true,
      ),
      //fab to create screen
      floatingActionButton: OpenContainer(
        closedElevation: 0.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        closedBuilder: (context, action) => FloatingActionButton(
          elevation: 0.0,
          onPressed: action,
          child: const Icon(Icons.add),
        ),
        openBuilder: (context, action) => OfferCreateScreen(),
      ),
      //list of items
      body: Center(
          child: ListView.builder(
        itemCount: offers.lentgh,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => OfferCard(
          offer: offers[index],
        ),
      )),
    );
  }
}
