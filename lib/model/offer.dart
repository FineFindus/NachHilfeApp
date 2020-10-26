import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/utils/enums.dart';

class Offer {
  final int id;
  final Subject subject;
  final String userMail;
  final String topic;
  final int year;
  final int endDate;
  final bool isAccepted;
  final String acceptingUserMail;

  ///The Offer model
  Offer({
    this.id,
    this.acceptingUserMail,
    @required this.subject,
    @required this.userMail,
    @required this.topic,
    @required this.year,
    @required this.endDate,
    this.isAccepted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject?.toString(),
      'userMail': userMail,
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
      userMail: map['userMail'],
      topic: map['topic'],
      year: map['year'],
      endDate: map['endDate'],
      isAccepted: map['isAccepted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));

  ///Override toString, so the data of the offer is returned istead of intance
  @override
  String toString() {
    return 'Offer(id: $id, subject: $subject, userMail: $userMail, topic: $topic, year: $year, endDate: $endDate, isAccepted: $isAccepted)';
  }

  Offer copyWith({
    int id,
    Subject subject,
    String userMail,
    String topic,
    int year,
    int endDate,
    bool isAccepted,
  }) {
    return Offer(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      userMail: userMail ?? this.userMail,
      topic: topic ?? this.topic,
      year: year ?? this.year,
      endDate: endDate ?? this.endDate,
      isAccepted: isAccepted ?? this.isAccepted,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Offer &&
        o.id == id &&
        o.subject == subject &&
        o.userMail == userMail &&
        o.topic == topic &&
        o.year == year &&
        o.endDate == endDate &&
        o.isAccepted == isAccepted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        subject.hashCode ^
        userMail.hashCode ^
        topic.hashCode ^
        year.hashCode ^
        endDate.hashCode ^
        isAccepted.hashCode;
  }
}
