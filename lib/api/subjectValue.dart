//return a string from the subject enum value
import 'package:NachHilfeApp/generated/l10n.dart';
import 'package:NachHilfeApp/utils/enums.dart';
import 'package:flutter/cupertino.dart';

String getTranlatedSubject(BuildContext context, Subject? subject) {
  switch (subject) {
    case Subject.math:
      return S.of(context)!.subject_math;
      break;
    case Subject.english:
      return S.of(context)!.subject_english;
      break;
    case Subject.german:
      return S.of(context)!.subject_german;
      break;
    case Subject.art:
      return S.of(context)!.subject_art;
      break;
    case Subject.biologie:
      return S.of(context)!.subject_biologie;
      break;
    case Subject.chemistry:
      return S.of(context)!.subject_chemistry;
      break;
    case Subject.geography:
      return S.of(context)!.subject_geography;
      break;
    case Subject.history:
      return S.of(context)!.subject_history;
      break;
    case Subject.music:
      return S.of(context)!.subject_music;
      break;
    case Subject.physical_education:
      return S.of(context)!.subject_physical_education;
      break;
    case Subject.physics:
      return S.of(context)!.subject_physics;
      break;
    default:
      return "Error";
  }
}

Subject? getSubjectFromString(String? subjectAsString) {
  for (Subject element in Subject.values) {
    if (element.toString() == subjectAsString) {
      return element;
    }
  }
  return null;
}
