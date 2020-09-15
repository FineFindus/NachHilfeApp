//return a string from the subject enum value
import 'package:NachHilfeApp/utils/enums.dart';

String getTranlatedSubject(Subject subject) {
  switch (subject) {
    case Subject.math:
      return "Mathe";
      break;
    case Subject.english:
      return "Englisch";
      break;
    case Subject.german:
      return "Englisch";
      break;
    case Subject.art:
      return "Kunst";
      break;
    case Subject.biologie:
      return "Biologie";
      break;
    case Subject.chemistry:
      return "Chemie";
      break;
    case Subject.geography:
      return "Erdkunde";
      break;
    case Subject.history:
      return "Geschichte";
      break;
    case Subject.music:
      return "Musik";
      break;
    case Subject.physical_education:
      return "Sport";
      break;
    case Subject.physics:
      return "Physik";
      break;
    default:
      return "Error";
  }
}

Subject getSubjectFromString(String subjectAsString) {
  for (Subject element in Subject.values) {
    if (element.toString() == subjectAsString) {
      return element;
    }
  }
  return null;
}
