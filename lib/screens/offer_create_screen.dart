import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfferCreateScreen extends StatelessWidget {
//form key to validate input
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create new Search")),
      body: Container(
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
                          // controller: nameTextController,
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
                          // controller: contactTextController,
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
                                final DateTime dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime(2101));
                                print(dateTime);

                                _formKey.currentState.validate();
                              },
                            )),
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

  ///Creates an [Offer], then it send the offer to the server in
  ///form of an POST-Request.
  void createOffer() {
    //create offer
    Offer(
        subject: Subject.math,
        name: "Jonathan",
        contact: "Jonathan@benzler.com",
        topic: "Functions",
        year: 11,
        isAccepted: false,
        endDate: DateTime.now().millisecondsSinceEpoch);
    //send post request
  }
}
