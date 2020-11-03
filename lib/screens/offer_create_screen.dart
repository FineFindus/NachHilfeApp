import 'dart:convert';

import 'package:NachHilfeApp/api/api_client.dart';
import 'package:NachHilfeApp/utils/topic_list.dart';
import 'package:NachHilfeApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';

import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/model/offer.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:NachHilfeApp/widgets/offer_card.dart';
import 'package:profanity_filter/profanity_filter.dart';

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

  //list to choose topic
  List<dynamic> stringValues = [];
  List<bool> values = [];

  //text controller for other topic field
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //get topic values
    updateTopics();
  }

  @override
  void dispose() {
    //dispose controller
    otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).offer_create_title),
      ),
      body: Stepper(
        physics: BouncingScrollPhysics(),
        steps: _mySteps(),
        currentStep: this._currentStep,
        onStepTapped: (step) {
          setState(() {
            this._currentStep = step;
          });
        },
        onStepContinue: () async {
          if (this._currentStep < this._mySteps().length - 1) {
            setState(() {
              this._currentStep = this._currentStep + 1;
            });
          } else {
            //user has completed all steps
            Offer offer = await createOffer();
            if (offer != null) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
              //post offer to server
              await ApiClient.postOffer(offer);
              //close dialog
              Navigator.of(context).pop();
              //then close screen
              Navigator.of(context).pop();
            }
          }
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
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              textTheme: ButtonTextTheme.normal,
              child: Text(_currentStep != _mySteps().length - 1
                  ? MaterialLocalizations.of(context).continueButtonLabel
                  : S.of(context).create),
              //check if user is allowed to create offer by checking if atleast one topic is selected
              onPressed: _currentStep == _mySteps().length - 1 &&
                      values.where((element) => element).isEmpty
                  ? null
                  : onStepContinue,
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
              title:
                  Text(S.of(context).offer_create_listtile_label_year(_year)),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => _ChooseYearDialog(
                        startPosition: _year,
                        onValueChanged: (value) {
                          setState(() {
                            _year = value;
                          });
                        },
                      )).then((value) => updateTopics()),
            ),
            ListTile(
              leading: Icon(Icons.class_),
              title: Text(S.of(context).offer_create_listtile_label_subject(
                  getTranlatedSubject(context, _subject))),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => _ChooseSubjectDialog(
                        startPosition: _subject,
                        onSubjectChanged: (value) {
                          setState(() {
                            _subject = value;
                          });
                        },
                      )).then((value) => updateTopics()),
            ),
          ],
        ),
      ),
      Step(
        isActive: _currentStep >= 1,
        state: _getStepStateTopics(),
        title: Text(S.of(context).offer_create_topic),
        subtitle: values.where((element) => element).isEmpty
            ? Text(S.of(context).offer_create_topic_error)
            : null,
        content: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: stringValues.length,
          itemBuilder: (context, index) => CheckboxListTile(
            value: values[index],
            title: index != values.length - 1
                ? Text(stringValues[index])
                : TextField(
                    controller: otherController,
                    decoration: InputDecoration(labelText: stringValues[index]),
                  ),
            onChanged: (value) => setState(() {
              values[index] = value;
            }),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
      ),
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

  ///Shows a date picker to pick a ending date for the offer
  ///the date is saved with setstate as pickedDate
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

  updateTopics() async {
    try {
      var result = await createTopicsList(context, _year, _subject);
      //add base knowledge option
      //TODO replace with localized strings from S.of(context)
      result.insert(0, S.of(context).topic_basic);
      //add other option at the end
      result.add(S.of(context).offer_create_textfield_label_other);
      //refresh
      setState(() {
        stringValues = result;
        values = List<bool>.generate(stringValues.length, (int index) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  ///Creates an [Offer], from the choosen data
  Future<Offer> createOffer() async {
    //get name and conact
    var storage = FlutterSecureStorage();
    var mail = await storage.read(key: "user_email");

    //get topics
    var choosenTopics = [];

    for (var i = 0; i < stringValues.length; i++) {
      if (values[i]) {
        //add to choosen topics
        //if is not last element
        if (i != values.length - 1) choosenTopics.add(stringValues[i]);
        //else
        //choosenTopics.add("value");
      }
    }

    //check if text controller is not empty
    if (otherController.text.trim().isNotEmpty && values.last) {
      //load bad words list to filter
      //filter for bad words
      final filter = ProfanityFilter.filterAdditionally(await _loadBadWords());
      //filter the text from the text field
      String cleanedString = filter.censor(otherController.text.trim());
      //add string
      choosenTopics.add(cleanedString);
    }
    //create offer
    Offer offer = Offer(
        year: _year,
        subject: _subject,
        userMail: mail,
        topic:
            "${choosenTopics.toString().replaceAll("[", "").replaceAll("]", "")}",
        isAccepted: false,
        endDate:
            pickedDate.isAfter(DateTime.now()) ? pickedDate : DateTime.now());

    return offer;
  }

  ///Loads a list with bad wods from assets and returns a string list
  Future<List<String>> _loadBadWords() async {
    var json = await rootBundle.loadString("assets/bad_word.json");
    //decode the file as a list of strings
    try {
      List<String> result = (jsonDecode(json) as List<dynamic>).cast<String>();
      //return result
      return result;
    } catch (e) {
      //on error return an empty list
      return [];
    }
  }

  ///Returns a stepsate for the topics step.
  ///Returns a StepState.error if no elemnts are selected
  StepState _getStepStateTopics() {
    if (values.where((element) => element).isEmpty) {
      return StepState.error;
    } else if (_currentStep == 1) {
      return StepState.editing;
    }
    return StepState.indexed;
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
