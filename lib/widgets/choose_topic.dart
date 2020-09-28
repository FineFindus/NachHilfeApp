import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:flutter/material.dart';

class ChooseTopic extends StatefulWidget {
  @override
  _ChooseTopicState createState() => _ChooseTopicState();
}

class _ChooseTopicState extends State<ChooseTopic> {
  List<bool> values = [
    false,
    true,
    true,
    true,
    true,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => CheckboxListTile(
          value: values[index],
          title: Text("Basiswissen"),
          onChanged: (value) => setState(() {
            values[index] = value;
          }),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }

  createTopicList(int year, Subject subject) {
    return S.of(context).create;
  }
}
