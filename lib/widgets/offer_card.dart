import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard({
    Key key,
    @required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //parse date
    var date = DateTime.fromMillisecondsSinceEpoch(
        offer.endDate + Duration(hours: 2).inMilliseconds);
    var formattedDate = DateFormat("dd.MM").format(date);

    //is date nearer then 3 days? if yes, make the text red, to indicate its soon
    var redText = (DateTime.now().millisecondsSinceEpoch +
            Duration(days: 3).inMilliseconds) >=
        offer.endDate;

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
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
