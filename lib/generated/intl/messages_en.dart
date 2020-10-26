// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(subject) => "Subject: ${subject}";

  static m1(year) => "Year: ${year}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "offer_create_class_and_year" : MessageLookupByLibrary.simpleMessage("Class and year"),
    "offer_create_dialog_class_title" : MessageLookupByLibrary.simpleMessage("Choose a class"),
    "offer_create_dialog_subject_title" : MessageLookupByLibrary.simpleMessage("Choose a subject"),
    "offer_create_end_date" : MessageLookupByLibrary.simpleMessage("End date"),
    "offer_create_error" : MessageLookupByLibrary.simpleMessage("An error occured"),
    "offer_create_listtile_label_subject" : m0,
    "offer_create_listtile_label_year" : m1,
    "offer_create_preview" : MessageLookupByLibrary.simpleMessage("Preview"),
    "offer_create_preview_text" : MessageLookupByLibrary.simpleMessage("Here is a small preview of your search. Do you want to create this search?"),
    "offer_create_textfield_label_other" : MessageLookupByLibrary.simpleMessage("Other"),
    "offer_create_title" : MessageLookupByLibrary.simpleMessage("Create new Search"),
    "offer_create_topic" : MessageLookupByLibrary.simpleMessage("Topic"),
    "offer_details_button_label_accept" : MessageLookupByLibrary.simpleMessage("Accept"),
    "offer_details_label_endDate" : MessageLookupByLibrary.simpleMessage("Enddate"),
    "offer_details_label_subject" : MessageLookupByLibrary.simpleMessage("Subject:"),
    "offer_details_label_topics" : MessageLookupByLibrary.simpleMessage("Topics:"),
    "offer_details_label_year" : MessageLookupByLibrary.simpleMessage("Year:"),
    "offer_list_appbar_title" : MessageLookupByLibrary.simpleMessage("Searches"),
    "offer_list_connection_error" : MessageLookupByLibrary.simpleMessage("An error occured, please ensured that you´re connected to the internet."),
    "offer_list_connection_error_retry" : MessageLookupByLibrary.simpleMessage("Retry"),
    "offer_list_fab_create" : MessageLookupByLibrary.simpleMessage("Create"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "onboarding_textfield_label_name" : MessageLookupByLibrary.simpleMessage("Mail"),
    "onboaring_title" : MessageLookupByLibrary.simpleMessage("Please input your email address to contact you."),
    "onborading_textfield_error_name_empty" : MessageLookupByLibrary.simpleMessage("Please enter a valid email address"),
    "onborading_textfield_error_name_numbers" : MessageLookupByLibrary.simpleMessage("The name can only consist of alphabetic letters"),
    "subject_art" : MessageLookupByLibrary.simpleMessage("art"),
    "subject_biologie" : MessageLookupByLibrary.simpleMessage("biologie"),
    "subject_chemistry" : MessageLookupByLibrary.simpleMessage("chemistry"),
    "subject_english" : MessageLookupByLibrary.simpleMessage("english"),
    "subject_geography" : MessageLookupByLibrary.simpleMessage("geography"),
    "subject_german" : MessageLookupByLibrary.simpleMessage("german"),
    "subject_history" : MessageLookupByLibrary.simpleMessage("history"),
    "subject_math" : MessageLookupByLibrary.simpleMessage("math"),
    "subject_music" : MessageLookupByLibrary.simpleMessage("music"),
    "subject_physical_education" : MessageLookupByLibrary.simpleMessage("physical education"),
    "subject_physics" : MessageLookupByLibrary.simpleMessage("physics"),
    "topic_basic" : MessageLookupByLibrary.simpleMessage("Basic knowledge")
  };
}
