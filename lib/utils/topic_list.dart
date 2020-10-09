import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'enums.dart';

///Retuns a list of Strngs from a json file called topcs.json
///to get all topics per subject and year
createTopicsList(BuildContext context, int year, Subject subject) async {
  //get topics json file from assets
  var json = await rootBundle.loadString("assets/topics.json");
  //decode the file and get the year and subject
  try {
    var result = jsonDecode(json)["$year"][subject.toString()];
    //return result
    return result;
  } catch (e) {
    //on error
    return ["Ein Fehler ist aufgetreten"];
  }
}
