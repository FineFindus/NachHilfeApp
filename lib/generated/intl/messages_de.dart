// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static m0(bug_report_address) => "Es ist leider ein Fehler aufgetreten. Du kannst den Fehler an ${bug_report_address} melden.";

  static m1(recipentName, subject) => "Hallo ${recipentName}, ich habe deine Nachhilfe Suche zu dem Fach ${subject} angenommen. Wann können wir uns treffen?";

  static m2(subject) => "Fach: ${subject}";

  static m3(year) => "Klasse: ${year}";

  static m4(email) => "Das Annehmen ist verbindlich. Bitte schreibe nach dem Annehmen direkt eine Email an ${email}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "create" : MessageLookupByLibrary.simpleMessage("Erstellen"),
    "error_occurred_report_bug" : m0,
    "mail_helper_text_body" : m1,
    "offer_create_class_and_year" : MessageLookupByLibrary.simpleMessage("Klasse und Fach"),
    "offer_create_dialog_class_title" : MessageLookupByLibrary.simpleMessage("Wähle eine Klasse"),
    "offer_create_dialog_subject_title" : MessageLookupByLibrary.simpleMessage("Wähle ein Fach"),
    "offer_create_end_date" : MessageLookupByLibrary.simpleMessage("Ablaufdatum"),
    "offer_create_error" : MessageLookupByLibrary.simpleMessage("Ein Fehler ist aufgetreten"),
    "offer_create_listtile_label_subject" : m2,
    "offer_create_listtile_label_year" : m3,
    "offer_create_preview" : MessageLookupByLibrary.simpleMessage("Preview"),
    "offer_create_preview_text" : MessageLookupByLibrary.simpleMessage("Hier ist eine Vorschau wie diese Suche aussieht, Möchtest du die Suche so erstellen?"),
    "offer_create_textfield_label_other" : MessageLookupByLibrary.simpleMessage("Anderes"),
    "offer_create_title" : MessageLookupByLibrary.simpleMessage("Neue Suche erstellen"),
    "offer_create_topic" : MessageLookupByLibrary.simpleMessage("Thema"),
    "offer_create_topic_error" : MessageLookupByLibrary.simpleMessage("Es muss mindestens ein Thema ausgewählt sein"),
    "offer_details_button_label_accept" : MessageLookupByLibrary.simpleMessage("Annehmen"),
    "offer_details_info_accepting" : m4,
    "offer_details_info_accepting_user" : MessageLookupByLibrary.simpleMessage("den Nutzer"),
    "offer_details_label_accepted" : MessageLookupByLibrary.simpleMessage("Angenommen:"),
    "offer_details_label_endDate" : MessageLookupByLibrary.simpleMessage("Enddatum:"),
    "offer_details_label_mailAddress" : MessageLookupByLibrary.simpleMessage("Email:"),
    "offer_details_label_subject" : MessageLookupByLibrary.simpleMessage("Fach:"),
    "offer_details_label_topics" : MessageLookupByLibrary.simpleMessage("Themen:"),
    "offer_details_label_year" : MessageLookupByLibrary.simpleMessage("Jahr:"),
    "offer_list_appbar_title" : MessageLookupByLibrary.simpleMessage("Suchen"),
    "offer_list_connection_error" : MessageLookupByLibrary.simpleMessage("Ein Fehler ist aufgetreten, bitte versichere das du eine Internetverbindung hast und versuche es erneut. Derzeit funktioniert die App nur wenn du mit dem Schulnetzwerk verbunden bist."),
    "offer_list_connection_error_retry" : MessageLookupByLibrary.simpleMessage("Erneut versuchen"),
    "offer_list_fab_create" : MessageLookupByLibrary.simpleMessage("Erstellen"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "onboarding_textfield_label_name" : MessageLookupByLibrary.simpleMessage("Email"),
    "onboarding_title" : MessageLookupByLibrary.simpleMessage("Bitte trage deine Email-Adresse ein, damit man dich darüber kontaktieren kann"),
    "onboarding_verification_error" : MessageLookupByLibrary.simpleMessage("Bitte trage die richtigen Zahlen ein"),
    "onboarding_verification_title" : MessageLookupByLibrary.simpleMessage("Bitte trage einen Verfikationscode ein, welcher dir per Email zugesand wurde."),
    "onborading_textfield_error_name_empty" : MessageLookupByLibrary.simpleMessage("Bitte trage eine richtige Email-Adresse ein"),
    "onborading_textfield_error_name_numbers" : MessageLookupByLibrary.simpleMessage("Bitte trage eine richtige Email-Adresse ein"),
    "settings_screen_button_label_logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "settings_screen_listtile_label_default_subject" : MessageLookupByLibrary.simpleMessage("Standard Fach"),
    "settings_screen_listtile_label_default_year" : MessageLookupByLibrary.simpleMessage("Standard Jahr"),
    "settings_screen_switch_label_darkmode" : MessageLookupByLibrary.simpleMessage("Darkmode"),
    "settings_screen_title" : MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "subject_art" : MessageLookupByLibrary.simpleMessage("Kunst"),
    "subject_biologie" : MessageLookupByLibrary.simpleMessage("Biologie"),
    "subject_chemistry" : MessageLookupByLibrary.simpleMessage("Chemie"),
    "subject_english" : MessageLookupByLibrary.simpleMessage("Englisch"),
    "subject_geography" : MessageLookupByLibrary.simpleMessage("Erdkunde"),
    "subject_german" : MessageLookupByLibrary.simpleMessage("Deutsch"),
    "subject_history" : MessageLookupByLibrary.simpleMessage("Geschichte"),
    "subject_math" : MessageLookupByLibrary.simpleMessage("Mathe"),
    "subject_music" : MessageLookupByLibrary.simpleMessage("Musik"),
    "subject_physical_education" : MessageLookupByLibrary.simpleMessage("Sport"),
    "subject_physics" : MessageLookupByLibrary.simpleMessage("Physik"),
    "topic_basic" : MessageLookupByLibrary.simpleMessage("Basiswissen")
  };
}
