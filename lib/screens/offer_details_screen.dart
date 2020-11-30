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
import 'package:url_launcher/url_launcher.dart';

class OfferDetailsScreen extends StatefulWidget {
  @override
  _OfferDetailsScreenState createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen>
    with SingleTickerProviderStateMixin {
  //if a resquest was send and is now loading
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    //get selected offer from Provider
    Offer offer = Provider.of<OfferLogic>(context).offer;

    print(offer);

    if (offer == null)
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(offer.toString()),
        ),
      );

    var formattedDate = DateFormat("dd.MM").format(offer.endDate);

    //is date nearer then 3 days? if yes, make the text red, to indicate its soon
    var redText =
        (DateTime.now().add(Duration(days: 3)).isAfter(offer.endDate));

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${getTranlatedSubject(context, offer.subject)}, ${offer.year}"),
      ),
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
                  trailing: SizedBox(
                    width: 200,
                    child: SingleChildScrollView(
                      child: Text(
                        offer.topic,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
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
                ListTile(
                  title: Text(S.of(context).offer_details_label_accepted),
                  trailing: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Icon(offer.isAccepted ? Icons.check : Icons.clear,
                        color: offer.isAccepted ? Colors.green : Colors.red,
                        key: Key(offer.isAccepted.toString())),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: offer.isAccepted
                      ? ListTile(
                          onTap: () async {
                            final url =
                                "mailto:${offer.userMail}?subject=Nachhilfe&body=${S.of(context).mail_helper_text_body(offer.userMail, getTranlatedSubject(context, offer.subject))}";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          title: Text(
                              S.of(context).offer_details_label_mailAddress),
                          trailing: Text(offer.userMail,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue)),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          ListTile(
              title: Center(
                  child: Text(S.of(context).offer_details_info_accepting(
                      offer.isAccepted
                          ? offer.userMail
                          : S.of(context).offer_details_info_accepting_user)))),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: SizedBox(
              width: double.infinity,
              //height: 70.0,
              child: AnimatedSize(
                vsync: this,
                duration: const Duration(milliseconds: 500),
                //height: _isLoading ? 70.0 : null,
                child: CupertinoButton.filled(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check),
                                const SizedBox(width: 10),
                                Text(
                                  S
                                      .of(context)
                                      .offer_details_button_label_accept,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ],
                            ),
                    ),
                    onPressed:
                        offer.isAccepted ? null : () => _acceptOffer(offer)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///Updates the offer in the backend
  Future<void> _acceptOffer(Offer offer) async {
    //only update while not loading
    if (!_isLoading) {
      //check if user has a mail address
      var storage = FlutterSecureStorage();
      var mail = await storage.read(key: "user_email");
      if (mail != null) {
        //update offer data
        Offer updatedOffer = offer.copyWith(
          acceptingUserMail: mail,
          isAccepted: true,
        );

        //set loading
        setState(() {
          _isLoading = true;
        });
        //send post to server
        await ApiClient.updateOffer(updatedOffer);
        //await Future.delayed(Duration(seconds: 2));
        Provider.of<OfferLogic>(context, listen: false).setOffer = updatedOffer;
        Provider.of<OfferLogic>(context, listen: false).removeOffer(offer);

        //cancel loading
        setState(() {
          _isLoading = false;
        });
      } else {
        //push back to login screen
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OnboardingScreen()));
      }
    }
  }
}
