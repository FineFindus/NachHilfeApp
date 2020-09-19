import 'package:NachHilfeApp/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //text controller for user name
  TextEditingController nameTextController = TextEditingController();
  //text controller for contact
  TextEditingController contactTextController = TextEditingController();

  @override
  void dispose() {
    //dispose text controller
    nameTextController.dispose();
    contactTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Card(
            child: Column(
              children: [
                Text(
                    "Please input your name and how to contact you (e.g. email.address)."),
                ListTile(
                  title: TextField(
                    controller: nameTextController,
                  ),
                ),
                ListTile(
                  title: TextField(
                    controller: contactTextController,
                  ),
                ),
                OutlineButton(
                  //store name and contact on press
                  onPressed: () async {
                    if (nameTextController.text.trim().isNotEmpty &&
                        contactTextController.text.trim().isNotEmpty) {
                      await storeNameAndContact(nameTextController.text.trim(),
                          contactTextController.text.trim());
                      //push and replace with new screen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OfferListScreen(),
                      ));
                    }
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Stores the users name and contact (e.g. email address) in the keychain for ios
  /// and the keystore for android.
  /// This can only be used with android api 18 and above.
  Future<void> storeNameAndContact(String name, String contact) async {
    //store name
    await FlutterKeychain.put(key: 'user_name', value: name);

    //store user contact
    await FlutterKeychain.put(key: 'user_contact', value: contact);
  }
}
