import 'package:NachHilfeApp/screens/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mdi/mdi.dart';

import 'offer_create_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //settings witch value
  //TODO remove later and replace with crrect value from settings
  bool switchDarkMode = false;

  //settings witch value
  //TODO remove later and replace with crrect value from settings
  int classYear = 5;

  //secure storage for mail address
  var secureStorage = FlutterSecureStorage();

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
            FutureBuilder(
              future: secureStorage.read(key: "user_email"),
              builder: (context, snapshot) => ListTile(
                leading: Icon(Icons.account_circle),
                title: snapshot.hasData
                    ? Text(snapshot.data)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()]),
              ),
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
          secondary: Icon(Mdi.themeLightDark),
          title: Text("Darkmode"),
          value: switchDarkMode,
          onChanged: (value) => setState(() {
            switchDarkMode = value;
          }),
        ),
        ListTile(
          leading: Icon(Mdi.teach),
          title: Text("Default year:"),
          trailing: Text("${classYear ?? 5}"),
          onTap: () => showDialog(
              context: context,
              builder: (context) => ChooseYearDialog(
                    startPosition: classYear,
                    onValueChanged: (value) {
                      setState(() {
                        classYear = value;
                      });
                    },
                  )),
        ),
        ListTile(
          leading: Icon(Mdi.tooltipPlus),
          title: Text("Default subject:"),
          trailing: Text("${classYear ?? 5}"),
          onTap: () => showDialog(
              context: context,
              builder: (context) => ChooseYearDialog(
                    startPosition: classYear,
                    onValueChanged: (value) {
                      setState(() {
                        classYear = value;
                      });
                    },
                  )),
        ),
      ]),
    );
  }

  ///LogOut function,
  ///Deletes the usermailAddress in the keyChain and pushes the login screen
  logOut() async {
    await secureStorage.deleteAll();
    //show login screen
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => OnboardingScreen(),
        ),
        (r) => false);
  }
}
