import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //text controller for user mail
  TextEditingController mailTextController = TextEditingController();

  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    //dispose text controller
    mailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.blueGrey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(S.of(context).onboaring_title),
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: mailTextController,
                          maxLines: null,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText:
                                S.of(context).onboarding_textfield_label_name,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (value) {
                            //check if value is not empty
                            if (value.isEmpty) {
                              return S
                                  .of(context)
                                  .onborading_textfield_error_name_empty;
                            }
                            //create regex
                            var regex = RegExp(
                                r"^[a-zA-Z]+\.+[a-zA-Z]+@(?:(?:[a-zA-Z0-9-]+\.)?[a-zA-Z]+\.)?igs-buchholz\.de$");
                            //check if word contains numbers
                            if (!regex.hasMatch(value.toLowerCase()))
                              return S
                                  .of(context)
                                  .onborading_textfield_error_name_numbers;
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          title: CupertinoButton.filled(
                              child: Text(
                                S.of(context).ok,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (mailTextController.text
                                      .trim()
                                      .isNotEmpty) {
                                    await storeMailAddress(
                                        mailTextController.text.trim());

                                    //push and replace with new screen
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => OfferListScreen(),
                                    ));
                                  }
                                }
                              })),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Stores the users name and contact (e.g. email address) in the keychain for ios
  /// and the keystore for android.
  /// This can only be used with android api 18 and above.
  Future<void> storeMailAddress(String mail) async {
    //store email address
    var storage = FlutterSecureStorage();
    await storage.write(key: "user_email", value: mail);

    //TODO: register mail and firebase push message token to server
    ApiClient.registerUserWithToken(mail, "TODO: token");
  }
}
