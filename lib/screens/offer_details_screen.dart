import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/screens/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OfferDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //get selected offer from Provider
    final Offer offer = Provider.of<OfferLogic>(context).offer;

    if (offer == null || offer.isAccepted ?? false)
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text("Fehler"),
        ),
      );

    var formattedDate = DateFormat("dd.MM")
        .format(DateTime.fromMillisecondsSinceEpoch(offer.endDate));

    //is date nearer then 3 days? if yes, make the text red, to indicate its soon
    var redText = (DateTime.now().millisecondsSinceEpoch +
            Duration(days: 3).inMilliseconds) >=
        offer.endDate;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ListTile(
                    title: Text("Jahrgang:"), trailing: Text("${offer.year}")),
                ListTile(
                    title: Text("Fach:"),
                    trailing:
                        Text(getTranlatedSubject(context, offer.subject))),
                ListTile(
                  title: Text("Themen:"),
                  trailing: Text(offer.topic),
                ),
                ListTile(
                  title: Text("Enddatum:"),
                  trailing: Text(
                    formattedDate,
                    style: redText
                        ? TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w700)
                        : null,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CupertinoTheme(
                data: CupertinoThemeData(
                    primaryColor: CupertinoColors.activeBlue),
                child: CupertinoButton.filled(
                    child: Text(
                      "Annehmen",
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      //check if user has a mail address
                      var storage = FlutterSecureStorage();
                      var mail = await storage.read(key: "user_email");
                      if (mail != null) {
                        //TODO: update offer at server
                        ApiClient.updateOffer(offer);
                      } else {
                        //push back to login screen
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => OnboardingScreen()));
                      }
                    })),
          ),
        ],
      ),
    );
  }
}
