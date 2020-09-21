import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:NachHilfeApp/widgets/offer_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';

class OfferCreateScreen extends StatefulWidget {
//form key to validate input
  @override
  _OfferCreateScreenState createState() => _OfferCreateScreenState();
}

class _OfferCreateScreenState extends State<OfferCreateScreen> {
  //current step
  int _currentStep = 0;

  //picked date by datepicker
  DateTime pickedDate = DateTime.now().add(Duration(days: 1));

  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neue Suche erstellen"),
      ),
      body: Stepper(
        steps: _mySteps(),
        currentStep: this._currentStep,
        onStepTapped: (step) {
          setState(() {
            this._currentStep = step;
          });
        },
        onStepContinue: () {
          setState(() {
            if (this._currentStep < this._mySteps().length - 1) {
              this._currentStep = this._currentStep + 1;
            } else {
              //Logic to check if everything is completed
              print('Completed, check fields.');
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (this._currentStep > 0) {
              this._currentStep = this._currentStep - 1;
            } else {
              this._currentStep = 0;
              //close windows
              Navigator.of(context).pop();
            }
          });
        },
        controlsBuilder: (context, {onStepCancel, onStepContinue}) {
          return Wrap(
            children: [
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: onStepContinue,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                textTheme: ButtonTextTheme.normal,
                child:
                    Text(MaterialLocalizations.of(context).continueButtonLabel),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 8.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: onStepCancel,
                  textTheme: ButtonTextTheme.normal,
                  child:
                      Text(MaterialLocalizations.of(context).cancelButtonLabel),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text("Klasse und Fach"),
        isActive: _currentStep >= 0,
        state: _currentStep == 0 ? StepState.editing : StepState.indexed,
        content: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Mdi.teach),
              title: Text("Klasse"),
            ),
            ListTile(
              leading: Icon(Icons.class_),
              title: Text("Fach"),
            ),
          ],
        ),
      ),
      Step(
          isActive: _currentStep >= 1,
          state: _currentStep == 1 ? StepState.editing : StepState.indexed,
          title: const Text('Thema'),
          content:
              RadioListTile(value: true, groupValue: null, onChanged: null)),
      Step(
          isActive: _currentStep >= 2,
          state: _currentStep == 2 ? StepState.editing : StepState.indexed,
          title: const Text('Ablaufdatum'),
          content: ListTile(
            leading: Icon(Icons.date_range),
            title: Text(DateFormat("EEEE, dd.MM").format(pickedDate)),
            onTap: chooseDate,
          )),
      Step(
          isActive: _currentStep >= 3,
          state: _currentStep == 3 ? StepState.editing : StepState.indexed,
          title: const Text('Preview'),
          content: Column(
            children: [
              ListTile(
                title: Text(
                    "Here is a small preview of your search. Do you want to create this search? "),
              ),
              OfferCard(offer: createOffer()),
            ],
          )),
    ];
    return _steps;
  }

  chooseDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  ///Creates an [Offer], from the choosen data
  Offer createOffer() {
    //create offer
    Offer offer = Offer(
        subject: Subject.math,
        name: "Jonathan",
        contact: "Jonathan@benzler.com",
        topic: "Functions",
        year: 11,
        isAccepted: false,
        endDate: pickedDate.millisecondsSinceEpoch);
    //send post request
    return offer;
  }
}
