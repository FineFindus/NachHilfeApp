import 'package:NachHilfeApp/utils/enums.dart';
import 'package:NachHilfeApp/utils/topic_list.dart';
import 'package:flutter/material.dart';

class ChooseTopic extends StatefulWidget {
  final int year;
  final Subject subject;

  const ChooseTopic({Key key, this.year, this.subject}) : super(key: key);
  @override
  _ChooseTopicState createState() => _ChooseTopicState();
}

class _ChooseTopicState extends State<ChooseTopic> {
  List<dynamic> stringValues = [];
  List<bool> values = [];

  @override
  void initState() {
    test(widget.year, widget.subject);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: stringValues.length,
        itemBuilder: (context, index) => CheckboxListTile(
          value: values[index],
          title: Text(stringValues[index]),
          onChanged: (value) => setState(() {
            values[index] = value;
          }),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }

  test(int year, Subject subject) async {
    var result = await createTopicsList(context, year, subject);
    stringValues = result;
    values = List<bool>.generate(stringValues.length, (int index) => false);
  }
}
