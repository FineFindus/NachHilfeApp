import 'package:NachHilfeApp/screens/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
              title: Text("Account"),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Jonathan.benzler@igs-buchholz.de"),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => logOut(),
            ),
          ]),
        ),
        SwitchListTile.adaptive(value: true, onChanged: null)
      ]),
    );
  }

  ///Checks if the user is logged in by chekcing the keychain.
  ///If the returned value is null the login screen is pushed.
  Future<void> _isLoggedIn() async {
    var storage = FlutterSecureStorage();
    var mail = await storage.read(key: "user_email");
    if (mail == null) {
      //push new screen
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (context) => OnboardingScreen(),
          ),
          (r) => false);
    }
  }

  ///LogOut function,
  ///Deletes the usermailAddress in the keyChain and pushes the login screen
  logOut() async {
    var storage = FlutterSecureStorage();
    await storage.deleteAll();
    //show login screen
    _isLoggedIn();
  }
}
