import 'dart:convert';

import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'enums.dart';

///DO NOT TOUCH THISFUNCTION
///ITS A MESS AND I KNOW THAT
createTopicsList(BuildContext context, int year, Subject subject) async {
  //get topics json file from assets
  var json = await rootBundle.loadString("assets/topics.json");
  //decode the file and get the year and subject
  var result = jsonDecode(json)["$year"][subject.toString()];
  //return result
  return result;
}
