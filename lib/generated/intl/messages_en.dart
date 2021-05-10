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

  static m0(bug_report_address) => "An error occured. We are very sorry for this inconvienience. You can report the bug at ${bug_report_address}.";

  static m1(recipentName, subject) => "Hello ${recipentName}, i accepted you coaching search for ${subject}. When do we meet?";

  static m2(subject) => "Subject: ${subject}";

  static m3(year) => "Year: ${year}";

  static m4(email) => "On accepting the date is binding. Please write immediately an email to ${email}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "error_occurred_report_bug" : m0,
    "mail_helper_text_body" : m1,
    "offer_create_class_and_year" : MessageLookupByLibrary.simpleMessage("Class and year"),
    "offer_create_dialog_class_title" : MessageLookupByLibrary.simpleMessage("Choose a class"),
    "offer_create_dialog_subject_title" : MessageLookupByLibrary.simpleMessage("Choose a subject"),
    "offer_create_end_date" : MessageLookupByLibrary.simpleMessage("End date"),
    "offer_create_error" : MessageLookupByLibrary.simpleMessage("An error occured"),
    "offer_create_listtile_label_subject" : m2,
    "offer_create_listtile_label_year" : m3,
    "offer_create_preview" : MessageLookupByLibrary.simpleMessage("Preview"),
    "offer_create_preview_text" : MessageLookupByLibrary.simpleMessage("Here is a small preview of your search. Do you want to create this search?"),
    "offer_create_textfield_label_other" : MessageLookupByLibrary.simpleMessage("Other"),
    "offer_create_title" : MessageLookupByLibrary.simpleMessage("Create new Search"),
    "offer_create_topic" : MessageLookupByLibrary.simpleMessage("Topic"),
    "offer_create_topic_error" : MessageLookupByLibrary.simpleMessage("Atleast one topics mst be selected"),
    "offer_details_button_label_accept" : MessageLookupByLibrary.simpleMessage("Accept"),
    "offer_details_info_accepting" : m4,
    "offer_details_info_accepting_user" : MessageLookupByLibrary.simpleMessage("the user"),
    "offer_details_label_accepted" : MessageLookupByLibrary.simpleMessage("Accepted:"),
    "offer_details_label_endDate" : MessageLookupByLibrary.simpleMessage("Enddate:"),
    "offer_details_label_mailAddress" : MessageLookupByLibrary.simpleMessage("Email:"),
    "offer_details_label_subject" : MessageLookupByLibrary.simpleMessage("Subject:"),
    "offer_details_label_topics" : MessageLookupByLibrary.simpleMessage("Topics:"),
    "offer_details_label_year" : MessageLookupByLibrary.simpleMessage("Year:"),
    "offer_list_appbar_title" : MessageLookupByLibrary.simpleMessage("Searches"),
    "offer_list_connection_error" : MessageLookupByLibrary.simpleMessage("An error occured, please ensured that you´re connected to the internet."),
    "offer_list_connection_error_retry" : MessageLookupByLibrary.simpleMessage("Retry"),
    "offer_list_fab_create" : MessageLookupByLibrary.simpleMessage("Create"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "onboarding_textfield_label_name" : MessageLookupByLibrary.simpleMessage("Mail"),
    "onboarding_title" : MessageLookupByLibrary.simpleMessage("Please input your email address to contact you."),
    "onboarding_verification_error" : MessageLookupByLibrary.simpleMessage("Please enter the correct code"),
    "onboarding_verification_title" : MessageLookupByLibrary.simpleMessage("Please enter a verfication code, which has been send to by an email"),
    "onborading_textfield_error_name_empty" : MessageLookupByLibrary.simpleMessage("Please enter a valid email address"),
    "onborading_textfield_error_name_numbers" : MessageLookupByLibrary.simpleMessage("The name can only consist of alphabetic letters"),
    "settings_screen_button_label_logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "settings_screen_listtile_label_default_subject" : MessageLookupByLibrary.simpleMessage("Default Subject"),
    "settings_screen_listtile_label_default_year" : MessageLookupByLibrary.simpleMessage("Default Year"),
    "settings_screen_switch_label_darkmode" : MessageLookupByLibrary.simpleMessage("Darkmode"),
    "settings_screen_title" : MessageLookupByLibrary.simpleMessage("Settings"),
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
