import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/widgets/widgets.dart';
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
      home: MyHomePage(title: 'Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Angebot"),
      ),
      body: Center(
        child: ListView(children: [
          OfferCard(),
        ]),
      ),
    );
  }
}
