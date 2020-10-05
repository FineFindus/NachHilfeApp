import 'dart:convert';

import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:flutter/material.dart';

import 'package:NachHilfeApp/utils/enums.dart';

class Offer {
  final int id;
  final Subject subject;
  final String name;
  final String topic;
  final int year;
  final int endDate;
  final bool isAccepted;

  ///The Offer model
  Offer({
    this.id,
    @required this.subject,
    @required this.name,
    @required this.topic,
    @required this.year,
    @required this.endDate,
    @required this.isAccepted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject.toString(),
      'name': name,
      'topic': topic,
      'year': year,
      'endDate': endDate,
      'isAccepted': isAccepted,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Offer(
        id: map['id'],
        subject: (getSubjectFromString(map['subject'])),
        name: map['name'],
        topic: map['topic'],
        year: map['year'],
        endDate: map['endDate'],
        isAccepted: map['isAccepted']);
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));

  ///Override toString, so the data of the offer is returned istead of intance
  @override
  String toString() {
    return "Offer{id: $id, subject: $subject, name: $name, contact: $name, topic: $topic, year: $year, endDate: $endDate, isAccepted: $isAccepted}";
  }
}
