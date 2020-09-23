import 'package:NachHilfeApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';

import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:NachHilfeApp/widgets/offer_card.dart';

class OfferCreateScreen extends StatefulWidget {
//form key to validate input
  @override
  _OfferCreateScreenState createState() => _OfferCreateScreenState();
}

class _OfferCreateScreenState extends State<OfferCreateScreen> {
  //current step
  int _currentStep = 0;

  //choosen subject
  Subject _subject = Subject.math;

  //choosen year/class
  int _year = 5;

  //picked date by datepicker
  DateTime pickedDate = DateTime.now().add(Duration(days: 4));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).offer_create_title),
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
        controlsBuilder: (context, {onStepCancel, onStepContinue}) => Wrap(
          children: [
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: onStepContinue,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              textTheme: ButtonTextTheme.normal,
              child: Text(_currentStep != _mySteps().length - 1
                  ? MaterialLocalizations.of(context).continueButtonLabel
                  : S.of(context).create),
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
        ),
      ),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text(S.of(context).offer_create_class_and_year),
        isActive: _currentStep >= 0,
        state: _currentStep == 0 ? StepState.editing : StepState.indexed,
        content: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Mdi.teach),
              title: Text("Klasse: $_year"),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => _ChooseYearDialog(
                        startPosition: _year,
                        onValueChanged: (value) => setState(() {
                          _year = value;
                        }),
                      )),
            ),
            ListTile(
              leading: Icon(Icons.class_),
              title: Text("Fach: ${getTranlatedSubject(context, _subject)}"),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => _ChooseSubjectDialog(
                        startPosition: _subject,
                        onSubjectChanged: (value) => setState(() {
                          _subject = value;
                        }),
                      )),
            ),
          ],
        ),
      ),
      Step(
          isActive: _currentStep >= 1,
          state: _currentStep == 1 ? StepState.editing : StepState.indexed,
          title: Text(S.of(context).offer_create_topic),
          content: ChooseTopic()),
      Step(
          isActive: _currentStep >= 2,
          state: _currentStep == 2 ? StepState.editing : StepState.indexed,
          title: Text(S.of(context).offer_create_end_date),
          content: ListTile(
            leading: Icon(Icons.date_range),
            title: Text(DateFormat("EEEE, dd.MM").format(pickedDate)),
            onTap: chooseDate,
          )),
      Step(
          isActive: _currentStep >= 3,
          state: _currentStep == 3 ? StepState.editing : StepState.indexed,
          title: Text(S.of(context).offer_create_preview),
          content: Column(
            children: [
              ListTile(
                title: Text(S.of(context).offer_create_preview_text),
              ),
              FutureBuilder<Offer>(
                future: createOffer(),
                builder: (context, snapshot) {
                  //check if connection is done
                  if (snapshot.hasData) return OfferCard(offer: snapshot.data);
                  return CircularProgressIndicator();
                },
              ),
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
  Future<Offer> createOffer() async {
    //get name and conact
    var name = await FlutterKeychain.get(key: "user_name");
    var contact = await FlutterKeychain.get(key: "user_contact");

    //create offer
    Offer offer = Offer(
        year: _year,
        subject: _subject,
        name: name,
        contact: contact,
        topic: "Functions",
        isAccepted: false,
        endDate: pickedDate.millisecondsSinceEpoch);

    return offer;
  }
}

///Shows a dialog with all subject values sorted alphabetically
class _ChooseSubjectDialog extends StatefulWidget {
  final Subject startPosition;
  final Function(Subject) onSubjectChanged;

  const _ChooseSubjectDialog({
    Key key,
    this.startPosition,
    @required this.onSubjectChanged,
  }) : super(key: key);

  @override
  State createState() => new _ChooseSubjectDialogState();
}

class _ChooseSubjectDialogState extends State<_ChooseSubjectDialog> {
  //current choosen subject
  Subject subject = Subject.art;

  //get subject list and make modifiable by calling .toList
  List<Subject> subjects = Subject.values.toList();

  @override
  void initState() {
    subject =
        widget.startPosition != null && subjects.contains(widget.startPosition)
            ? widget.startPosition
            : Subject.math;

    super.initState();
  }

  Widget build(BuildContext context) {
    //sort the list alphabetical
    subjects.sort((a, b) => getTranlatedSubject(context, a)
        .compareTo(getTranlatedSubject(context, b)));

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(S.of(context).offer_create_dialog_subject_title),
      content: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: subjects.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => RadioListTile(
                title: Text(getTranlatedSubject(context, subjects[index])),
                value: subjects[index],
                groupValue: subject,
                onChanged: (value) {
                  widget.onSubjectChanged(value);
                  setState(() {
                    subject = value;
                  });
                }),
          )),
      actions: [
        FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () => Navigator.of(context).pop(),
            color: Theme.of(context).accentColor,
            child: Text(S.of(context).ok))
      ],
    );
  }
}

///Shows a dialog with all subject values sorted alphabetically
class _ChooseYearDialog extends StatefulWidget {
  final int startPosition;
  final Function(int) onValueChanged;

  const _ChooseYearDialog({
    Key key,
    this.startPosition,
    @required this.onValueChanged,
  }) : super(key: key);

  @override
  State createState() => new _ChooseYearDialogState();
}

///Creates a dialog where the user chooses the year he is in
class _ChooseYearDialogState extends State<_ChooseYearDialog> {
  //current choosen subject
  int year = 5;

  //get subject list and make modifiable by calling .toList
  List<int> years = [
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
  ];

  @override
  void initState() {
    //set startpos if not null and in list
    year = widget.startPosition != null && years.contains(widget.startPosition)
        ? widget.startPosition
        : 5;

    super.initState();
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(S.of(context).offer_create_dialog_class_title),
      content: Container(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: years.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => RadioListTile(
                title: Text("${years[index]}"),
                value: years[index],
                groupValue: year,
                onChanged: (value) {
                  widget.onValueChanged(value);
                  setState(() {
                    year = value;
                  });
                }),
          )),
      actions: [
        FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () => Navigator.of(context).pop(),
            color: Theme.of(context).accentColor,
            child: Text(S.of(context).ok))
      ],
    );
  }
}
