import 'dart:convert';

import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/screens/offer_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'global/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //TODO add decrypted settings
  //check for encrytion key
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var containsEncryptionKey =
      await secureStorage.containsKey(key: 'settingsKey');
  if (!containsEncryptionKey) {
    //generate encryption key and save it in secure storage
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'settingsKey', value: base64UrlEncode(key));
  }

  var encryptionKey =
      base64Url.decode(await secureStorage.read(key: 'settingsKey'));

  //open hive here to avoid async code with encryption key
  await Hive.initFlutter();
  await Hive.openBox(settingsBox,
      encryptionCipher: HiveAesCipher(encryptionKey));
  // );
  //launch app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //get default system brightness
  final brightness = SchedulerBinding.instance.window.platformBrightness;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //create provider for statemanagment
        ChangeNotifierProvider(create: (_) => new OfferLogic()),
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          location: BannerLocation.bottomEnd,
          message: "BETA",
          color: Colors.red.shade700,
          child: ValueListenableBuilder(
            valueListenable: Hive.box(settingsBox).listenable(),
            builder: (context, box, widget) {
              //get darkMode from box, default follows system.
              var darkMode = box.get('darkMode',
                  defaultValue: brightness == Brightness.dark);
              return MaterialApp(
                title: 'Nachhilfe',
                themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
                //setting a custom theme with colors from igs logo
                theme: ThemeData(
                  cupertinoOverrideTheme: CupertinoThemeData(
                    primaryColor: Color(0xff00AC36),
                  ),
                  accentColor: Color(0xff00AC36),
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                darkTheme: ThemeData.dark().copyWith(
                  cupertinoOverrideTheme: CupertinoThemeData(
                    primaryColor: Color(0xff00AC36),
                  ),
                  accentColor: Color(0xff00AC36),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
