import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/screens/offer_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  try {
    ApiClient.getOffers();
  } catch (e) {
    print(e.runtimeType);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
