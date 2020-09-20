import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/screens/screens.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:NachHilfeApp/widgets/widgets.dart';
import 'package:animations/animations.dart';
import "package:flutter/material.dart";

class OfferListScreen extends StatefulWidget {
  @override
  _OfferListScreenState createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  //get offers
  var offers =
      // Provider.of<OfferLogic>(context).offers;
      [
    Offer(
        id: 1,
        subject: Subject.math,
        name: "Jonathan",
        contact: "Jonathan@benzler.com",
        topic: "Functions",
        year: 11,
        isAccepted: false,
        endDate: DateTime.now().millisecondsSinceEpoch)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).offer_list_appbar_title),
          centerTitle: true,
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
              await Future.delayed(Duration(seconds: 2));
              setState(() {});
            },
            child: FutureBuilder<List<Offer>>(
              future: ApiClient.getOffers(),
              builder: (context, snapshot) {
                //check if connection is done
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) =>
                          OfferCard(offer: snapshot.data[index]),
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 60, color: Colors.red),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child:
                              Text(S.of(context).offer_list_connection_error),
                        ),
                        const SizedBox(height: 10),
                        FloatingActionButton(
                          tooltip:
                              S.of(context).offer_list_connection_error_retry,
                          mini: true,
                          onPressed: () {
                            setState(() {});
                          },
                          child: Icon(Icons.refresh),
                        ),
                      ],
                    );
                  }
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ));
  }
}
