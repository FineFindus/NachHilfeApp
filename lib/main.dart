import 'package:NachHilfeApp/screens/offer_list_screen.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Subject.math);
    return MaterialApp(
      title: 'Nachhilfe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OfferListScreen(),
    );
  }
}
