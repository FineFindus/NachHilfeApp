import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/provider/offer_logic.dart';
import 'package:NachHilfeApp/screens/screens.dart';

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
                        child: Text(S.of(context).onboarding_title),
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

                                    //set user to logged in
                                    Provider.of<OfferLogic>(context,
                                            listen: false)
                                        .isLoggedIn = true;
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

  ///Stores the users name and contact (e.g. email address) in the keyChain for ios
  /// and the keystore for android.
  /// This can only be used with android api 18 and above.
  Future<void> storeMailAddress(String mail) async {
    //store email address
    var storage = FlutterSecureStorage();
    await storage.write(key: "user_email", value: mail);

    //send data to server
    await ApiClient.registerUserWithToken(mail, "");

    //show pin code field
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => EmailPinScreen(
        email: mail,
      ),
    ));
  }
}

class EmailPinScreen extends StatefulWidget {
  final String email;
  const EmailPinScreen({
    Key key,
    @required this.email,
  }) : super(key: key);
  @override
  _EmailPinScreenState createState() => _EmailPinScreenState();
}

class _EmailPinScreenState extends State<EmailPinScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S.of(context).onboarding_verification_title),
                ),
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor:
                            hasError ? Colors.blue.shade100 : Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) => verifyCode(),
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? S.of(context).onboarding_verification_error : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton.filled(
                    child: Text(
                      S.of(context).ok,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () => verifyCode()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  verifyCode() async {
    formKey.currentState.validate();
    // conditions for validating
    if (currentText.length != 6) {
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      setState(() {
        hasError = true;
      });
    } else {
      //text is long enough
      setState(
        () {
          hasError = false;
        },
      );
      // send to server for verification
      try {
        String id = await FlutterSecureStorage().read(key: "user_id");
        await ApiClient.login(id, int.parse(currentText));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => OfferListScreen(),
        ));
      } catch (e) {
        setState(() {
          hasError = true;
        });
      }
    }
  }
}
