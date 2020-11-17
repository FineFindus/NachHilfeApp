import 'package:NachHilfeApp/screens/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mdi/mdi.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //settings witch value
  //TODO remove later and replace with crrect value from settings
  bool switchDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(children: [
        Card(
          child: Column(children: [
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Jonathan.benzler@igs-buchholz.de"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => logOut(),
            ),
          ]),
        ),
        SwitchListTile.adaptive(
          secondary: Icon(Icons.brightness_4),
          title: Text("Darkmode"),
          value: switchDarkMode,
          onChanged: (value) => setState(() {
            switchDarkMode = value;
          }),
        ),
        ListTile(
            leading: Icon(Mdi.teach),
            title: Text("Default year:"),
            trailing: Text("11")),
      ]),
    );
  }

  ///LogOut function,
  ///Deletes the usermailAddress in the keyChain and pushes the login screen
  logOut() async {
    var storage = FlutterSecureStorage();
    await storage.deleteAll();
    //show login screen
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => OnboardingScreen(),
        ),
        (r) => false);
  }
}
