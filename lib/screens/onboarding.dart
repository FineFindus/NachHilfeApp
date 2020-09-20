import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/screens/screens.dart';
import 'package:flutter/cupertino.dart';
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

  //form key
  final _formKey = GlobalKey<FormState>();

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
                          controller: nameTextController,
                          maxLines: null,
                          textInputAction: TextInputAction.next,
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
                            var regex = RegExp(r"[0-9]");
                            //check if word contains numbers
                            if (regex.hasMatch(value))
                              return S
                                  .of(context)
                                  .onborading_textfield_error_name_numbers;
                            return null;
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: contactTextController,
                          maxLines: null,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: S
                                .of(context)
                                .onboarding_textfield_label_contact,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return S
                                  .of(context)
                                  .onborading_textfield_error_contact_empty;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: CupertinoTheme(
                            data: CupertinoThemeData(
                                primaryColor: CupertinoColors.activeBlue),
                            child: CupertinoButton.filled(
                                child: Text(S.of(context).ok),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    if (nameTextController.text
                                            .trim()
                                            .isNotEmpty &&
                                        contactTextController.text
                                            .trim()
                                            .isNotEmpty) {
                                      await storeNameAndContact(
                                          nameTextController.text.trim(),
                                          contactTextController.text.trim());

                                      print(await FlutterKeychain.get(
                                          key: 'user_name'));
                                      print(await FlutterKeychain.get(
                                          key: 'user_contact'));

                                      //push and replace with new screen
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) => OfferListScreen(),
                                      ));
                                    }
                                  }
                                })),
                      ),
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
  Future<void> storeNameAndContact(String name, String contact) async {
    //store name
    await FlutterKeychain.put(key: 'user_name', value: name);

    //store user contact
    await FlutterKeychain.put(key: 'user_contact', value: contact);
  }
}
