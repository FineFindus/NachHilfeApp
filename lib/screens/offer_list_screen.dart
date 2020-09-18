import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/screens/screens.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:NachHilfeApp/widgets/widgets.dart';
import 'package:animations/animations.dart';
import "package:flutter/material.dart";
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';

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
        endDate: DateTime.now().millisecondsSinceEpoch)
  ];

  @override
  Widget build(BuildContext context) {
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
                    print("new data");
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
                          child: Text(
                              "An error occured, please ensured that you´re connected to the internet"),
                        ),
                        const SizedBox(height: 10),
                        FloatingActionButton(
                          tooltip: "Retry",
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
        )

        //     child: RefreshIndicator(
        //   onRefresh: () async {
        //     setState(() {
        //       print("object");
        //       offers.add(
        //         Offer(
        //             id: 2,
        //             subject: Subject.math,
        //             name: "Test",
        //             contact: "Jonathan@benzler.com",
        //             topic: "Functions",
        //             year: 13,
        //             endDate: DateTime.now().millisecondsSinceEpoch),
        //       );
        //     });
        //     print(offers);
        //   },
        //   child: ImplicitlyAnimatedList<Offer>(
        //     items: offers,
        //     areItemsTheSame: (a, b) => a.id == b.id,
        //     itemBuilder: (context, animation, item, index) {
        //       return SizeFadeTransition(
        //         sizeFraction: 0.7,
        //         curve: Curves.easeInOut,
        //         animation: animation,
        //         child: GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 print(index);
        //                 offers.removeAt(index);
        //               });
        //             },
        //             child: OfferCard(offer: item)),
        //       );
        //     },
        //     removeItemBuilder: (context, animation, oldItem) {
        //       return SizeTransition(
        //         sizeFactor: animation,
        //         axis: Axis.vertical,
        //         child: OfferCard(offer: oldItem),
        //       );
        //     },
        //   ),
        // )),
        );
  }
}
