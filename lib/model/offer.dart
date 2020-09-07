import 'package:NachHilfeApp/enums/enums.dart';
import 'package:flutter/material.dart';

class Offer {
  final Subject subject;
  final String name;
  final String contact;
  final String topic;
  final int year;
  final int endDate;

  ///The Offer model
  Offer({
    @required this.subject,
    @required this.name,
    @required this.contact,
    @required this.topic,
    @required this.year,
    @required this.endDate,
  });
}
