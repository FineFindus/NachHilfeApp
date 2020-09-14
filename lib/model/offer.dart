import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:NachHilfeApp/utils/enums.dart';

class Offer {
  final int id;
  final Subject subject;
  final String name;
  final String contact;
  final String topic;
  final int year;
  final int endDate;

  ///The Offer model
  Offer({
    @required this.id,
    @required this.subject,
    @required this.name,
    @required this.contact,
    @required this.topic,
    @required this.year,
    @required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject?.toMap(),
      'name': name,
      'contact': contact,
      'topic': topic,
      'year': year,
      'endDate': endDate,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Offer(
      id: map['id'],
      subject: (map['subject']),
      name: map['name'],
      contact: map['contact'],
      topic: map['topic'],
      year: map['year'],
      endDate: map['endDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));
}
