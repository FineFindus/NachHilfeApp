import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/screens/screens.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  final Function onTap;

  const OfferCard({
    Key key,
    @required this.offer,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //parse date
    var date = offer.endDate.add(Duration(hours: 2));
    var formattedDate = DateFormat("dd.MM").format(offer.endDate);

    //is date nearer then 3 days? if yes, make the text red, to indicate its soon
    var redText =
        (DateTime.now().add(Duration(days: 3)).isAfter(offer.endDate));

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: onTap,
            title: Text(
                "${getTranlatedSubject(context, offer.subject)}  ${offer.year}"),
            subtitle: Text(offer.topic),
            trailing: Text(
              formattedDate,
              style: redText
                  ? TextStyle(color: Colors.red, fontWeight: FontWeight.w700)
                  : null,
            ),
          ),
        ));
  }
}
