import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/utils/enums.dart';

class Offer {
  final String? id;
  final Subject? subject;
  final String? userMail;
  final List<String>? topic;
  final int? year;
  final DateTime endDate;
  final bool? isAccepted;
  final String? acceptingUserMail;

  ///The Offer model
  Offer({
    this.id,
    required this.subject,
    required this.userMail,
    required this.topic,
    required this.year,
    required this.endDate,
    this.isAccepted = false,
    this.acceptingUserMail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject?.toString(),
      'userMail': userMail,
      'topic': topic,
      'year': year,
      'endDate': endDate.toIso8601String(),
      'isAccepted': isAccepted,
      'acceptingUserMail': acceptingUserMail,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['_id'],
      subject: (getSubjectFromString(map['subject'])),
      userMail: map['userMail'],
      topic: map['topic'].whereType<String>().toList(),
      year: map['year'],
      endDate: DateTime.parse(map['endDate']),
      // endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      isAccepted: map['isAccepted'],
      acceptingUserMail: map['acceptingUserMail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));

  ///Override toString, so the data of the offer is returned instead of instance
  @override
  String toString() {
    return 'Offer(id: $id, subject: $subject, userMail: $userMail, topic: $topic, year: $year, endDate: $endDate, isAccepted: $isAccepted, acceptingUserMail: $acceptingUserMail)';
  }

  Offer copyWith({
    int? id,
    Subject? subject,
    String? userMail,
    String? topic,
    int? year,
    DateTime? endDate,
    bool? isAccepted,
    String? acceptingUserMail,
  }) {
    return Offer(
      id: id as String? ?? this.id,
      subject: subject ?? this.subject,
      userMail: userMail ?? this.userMail,
      topic: topic as List<String>? ?? this.topic,
      year: year ?? this.year,
      endDate: endDate ?? this.endDate,
      isAccepted: isAccepted ?? this.isAccepted,
      acceptingUserMail: acceptingUserMail ?? this.acceptingUserMail,
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
        o.isAccepted == isAccepted &&
        o.acceptingUserMail == acceptingUserMail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        subject.hashCode ^
        userMail.hashCode ^
        topic.hashCode ^
        year.hashCode ^
        endDate.hashCode ^
        isAccepted.hashCode ^
        acceptingUserMail.hashCode;
  }
}
