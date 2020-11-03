import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/screens/onboarding.dart';
import 'package:NachHilfeApp/screens/screens.dart';
import 'package:NachHilfeApp/widgets/widgets.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class OfferListScreen extends StatefulWidget {
  @override
  _OfferListScreenState createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  @override
  void initState() {
    super.initState();

    //test if user is logged in, else push the login screen
    _isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).offer_list_appbar_title),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: logOut,
            )
          ],
        ),
        //fab to create screen
        floatingActionButton: OpenContainer(
          closedElevation: 0.0,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          closedBuilder: (context, action) => FloatingActionButton(
            tooltip: S.of(context).offer_list_fab_create,
            elevation: 0.0,
            onPressed: action,
            child: const Icon(Icons.add),
          ),
          openBuilder: (context, action) => OfferCreateScreen(),
        ),
        //list of items
        body: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              //wait for better visual indication that the app is refreshing.
              //otherwise if the data doesnt change the user might be confused and think it didnt refresh
              await Future.delayed(Duration(seconds: 1));
              //reload offers
              await Provider.of<OfferLogic>(context, listen: false)
                  .refreshOffers();
            },
            child: FutureBuilder<List<dynamic>>(
              future: Provider.of<OfferLogic>(context).offers,
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child:
                        //check if connection is done
                        (() {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) => OfferCard(
                              offer: snapshot.data[index],
                              onTap: () {
                                //set selected offer
                                Provider.of<OfferLogic>(context, listen: false)
                                    .setOffer = snapshot.data[index];
                                //push to details screen
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        OfferDetailsScreen()));
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, size: 150, color: Colors.red),
                              const SizedBox(height: 10),
                              Container(
                                  width: 300,
                                  child: Text(
                                    S.of(context).offer_list_connection_error,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 17),
                                  )),
                              const SizedBox(height: 20),
                              CupertinoButton.filled(
                                child: Icon(Icons.refresh),
                                onPressed: () => Provider.of<OfferLogic>(
                                        context,
                                        listen: false)
                                    .refreshOffers(),
                              ),

                              //tooltip:
                              //  S.of(context).offer_list_connection_error_retry,
                            ],
                          );
                        }
                      }
                      return CircularProgressIndicator();
                    }()));
              },
            ),
          ),
        ));
  }

  ///Checks if the user is logged in by chekcing the keychain.
  ///If the returned value is null the login screen is pushed.
  Future<void> _isLoggedIn() async {
    var storage = FlutterSecureStorage();
    var mail = await storage.read(key: "user_email");
    if (mail == null) {
      //push new screen
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (context) => OnboardingScreen(),
      ));
    }
  }

  ///LogOut function,
  ///Deletes the keyCahin and pushes the login screen
  logOut() async {
    var storage = FlutterSecureStorage();
    await storage.deleteAll();
    //show login screen
    _isLoggedIn();
  }
}
