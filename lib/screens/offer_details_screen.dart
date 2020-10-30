import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/generated/l10n.dart';
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
          child: Text(S.of(context).offer_create_error),
        ),
      );

    var formattedDate = DateFormat("dd.MM").format(offer.endDate);

    //is date nearer then 3 days? if yes, make the text red, to indicate its soon
    var redText =
        (DateTime.now().add(Duration(days: 3)).isAfter(offer.endDate));

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ListTile(
                    title: Text(S.of(context).offer_details_label_year),
                    trailing: Text("${offer.year}")),
                ListTile(
                    title: Text(S.of(context).offer_details_label_subject),
                    trailing:
                        Text(getTranlatedSubject(context, offer.subject))),
                ListTile(
                  title: Text(S.of(context).offer_details_label_topics),
                  trailing: Text(offer.topic),
                ),
                ListTile(
                  title: Text(S.of(context).offer_details_label_endDate),
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
            child: CupertinoButton.filled(
                child: Text(
                  S.of(context).offer_details_button_label_accept,
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  //check if user has a mail address
                  var storage = FlutterSecureStorage();
                  var mail = await storage.read(key: "user_email");
                  if (mail != null) {
                    //TODO: update offer at server
                    //send post to server
                    ApiClient.updateOffer(offer);
                  } else {
                    //push back to login screen
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OnboardingScreen()));
                  }
                }),
          ),
        ],
      ),
    );
  }
}
