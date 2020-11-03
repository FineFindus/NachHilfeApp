import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/screens/offer_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new OfferLogic()),
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          location: BannerLocation.bottomEnd,
          message: "BETA",
          color: Colors.red.shade700,
          child: MaterialApp(
            title: 'Nachhilfe',
            theme: ThemeData(
              cupertinoOverrideTheme: CupertinoThemeData(
                primaryColor: Color(0xff00AC36),
              ),
              accentColor: Color(0xff00AC36),
              //primaryColor: Color.fromARGB(255, 0, 122, 255),
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: OfferListScreen(),
          ),
        ),
      ),
    );
  }
}
