import 'dart:convert';

import 'package:NachHilfeApp/api/subjectValue.dart';
import 'package:NachHilfeApp/utils/enums.dart';

class Topic {
  final int? year;
  final Subject? subject;
  Topic({
    this.year,
    this.subject,
  });

  Topic copyWith({
    int? year,
    Subject? subject,
  }) {
    return Topic(
      year: year ?? this.year,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'subject': subject.toString(),
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      year: map['year'],
      subject: (getSubjectFromString(map['subject'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) => Topic.fromMap(json.decode(source));

  @override
  String toString() => 'Topic(year: $year, subject: $subject)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Topic && o.year == year && o.subject == subject;
  }

  @override
  int get hashCode => year.hashCode ^ subject.hashCode;
}
