import 'package:NachHilfeApp/enums/enums.dart';
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
    var date = DateTime.fromMillisecondsSinceEpoch(offer.endDate);
    var formattedDate = DateFormat("dd.MM").format(date);

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text("${getSubjectValue(offer.subject)}  ${offer.year}"),
            subtitle: Text(offer.topic),
            trailing: Text(formattedDate),
          ),
        ));
  }

  //return a string from the subject enum value
  String getSubjectValue(Subject subject) {
    switch (subject) {
      case Subject.math:
        return "Mathe";
        break;
      case Subject.english:
        return "Englisch";
        break;
      case Subject.german:
        return "Englisch";
        break;
      case Subject.art:
        return "Kunst";
        break;
      case Subject.biologie:
        return "Biologie";
        break;
      case Subject.chemistry:
        return "Chemie";
        break;
      case Subject.geography:
        return "Erdkunde";
        break;
      case Subject.history:
        return "Geschichte";
        break;
      case Subject.music:
        return "Musik";
        break;
      case Subject.physical_education:
        return "Sport";
        break;
      case Subject.physics:
        return "Physik";
        break;
      default:
        return "Error";
    }
  }
}
