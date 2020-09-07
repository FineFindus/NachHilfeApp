import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ExpansionTile(
          title: ListTile(
            title: Text("Mathe 8"),
            subtitle: Text("Funktionen und Terme"),
            trailing: Text("07.09"),
          ),
          children: [
            ListTile(),
          ],
        ));
  }
}
