import 'package:flutter/material.dart';

class ChooseTopic extends StatefulWidget {
  @override
  _ChooseTopicState createState() => _ChooseTopicState();
}

class _ChooseTopicState extends State<ChooseTopic> {
  List<bool> values = [
    true,
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
          title: Text("Funktionen"),
          onChanged: (value) => setState(() {
            values[index] = value;
          }),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}
