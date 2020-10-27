// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Please input your email address to contact you.`
  String get onboaring_title {
    return Intl.message(
      'Please input your email address to contact you.',
      name: 'onboaring_title',
      desc: '',
      args: [],
    );
  }

  /// `Mail`
  String get onboarding_textfield_label_name {
    return Intl.message(
      'Mail',
      name: 'onboarding_textfield_label_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get onborading_textfield_error_name_empty {
    return Intl.message(
      'Please enter a valid email address',
      name: 'onborading_textfield_error_name_empty',
      desc: '',
      args: [],
    );
  }

  /// `The name can only consist of alphabetic letters`
  String get onborading_textfield_error_name_numbers {
    return Intl.message(
      'The name can only consist of alphabetic letters',
      name: 'onborading_textfield_error_name_numbers',
      desc: '',
      args: [],
    );
  }

  /// `Searches`
  String get offer_list_appbar_title {
    return Intl.message(
      'Searches',
      name: 'offer_list_appbar_title',
      desc: '',
      args: [],
    );
  }

  /// `An error occured, please ensured that you´re connected to the internet.`
  String get offer_list_connection_error {
    return Intl.message(
      'An error occured, please ensured that you´re connected to the internet.',
      name: 'offer_list_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get offer_list_connection_error_retry {
    return Intl.message(
      'Retry',
      name: 'offer_list_connection_error_retry',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get offer_list_fab_create {
    return Intl.message(
      'Create',
      name: 'offer_list_fab_create',
      desc: '',
      args: [],
    );
  }

  /// `Create new Search`
  String get offer_create_title {
    return Intl.message(
      'Create new Search',
      name: 'offer_create_title',
      desc: '',
      args: [],
    );
  }

  /// `Class and year`
  String get offer_create_class_and_year {
    return Intl.message(
      'Class and year',
      name: 'offer_create_class_and_year',
      desc: '',
      args: [],
    );
  }

  /// `Topic`
  String get offer_create_topic {
    return Intl.message(
      'Topic',
      name: 'offer_create_topic',
      desc: '',
      args: [],
    );
  }

  /// `Atleast one topics mst be selected`
  String get offer_create_topic_error {
    return Intl.message(
      'Atleast one topics mst be selected',
      name: 'offer_create_topic_error',
      desc: '',
      args: [],
    );
  }

  /// `Year: {year}`
  String offer_create_listtile_label_year(Object year) {
    return Intl.message(
      'Year: $year',
      name: 'offer_create_listtile_label_year',
      desc: '',
      args: [year],
    );
  }

  /// `Subject: {subject}`
  String offer_create_listtile_label_subject(Object subject) {
    return Intl.message(
      'Subject: $subject',
      name: 'offer_create_listtile_label_subject',
      desc: '',
      args: [subject],
    );
  }

  /// `Basic knowledge`
  String get topic_basic {
    return Intl.message(
      'Basic knowledge',
      name: 'topic_basic',
      desc: '',
      args: [],
    );
  }

  /// `End date`
  String get offer_create_end_date {
    return Intl.message(
      'End date',
      name: 'offer_create_end_date',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get offer_create_preview {
    return Intl.message(
      'Preview',
      name: 'offer_create_preview',
      desc: '',
      args: [],
    );
  }

  /// `Here is a small preview of your search. Do you want to create this search?`
  String get offer_create_preview_text {
    return Intl.message(
      'Here is a small preview of your search. Do you want to create this search?',
      name: 'offer_create_preview_text',
      desc: '',
      args: [],
    );
  }

  /// `Choose a subject`
  String get offer_create_dialog_subject_title {
    return Intl.message(
      'Choose a subject',
      name: 'offer_create_dialog_subject_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose a class`
  String get offer_create_dialog_class_title {
    return Intl.message(
      'Choose a class',
      name: 'offer_create_dialog_class_title',
      desc: '',
      args: [],
    );
  }

  /// `An error occured`
  String get offer_create_error {
    return Intl.message(
      'An error occured',
      name: 'offer_create_error',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get offer_create_textfield_label_other {
    return Intl.message(
      'Other',
      name: 'offer_create_textfield_label_other',
      desc: '',
      args: [],
    );
  }

  /// `Year:`
  String get offer_details_label_year {
    return Intl.message(
      'Year:',
      name: 'offer_details_label_year',
      desc: '',
      args: [],
    );
  }

  /// `Subject:`
  String get offer_details_label_subject {
    return Intl.message(
      'Subject:',
      name: 'offer_details_label_subject',
      desc: '',
      args: [],
    );
  }

  /// `Topics:`
  String get offer_details_label_topics {
    return Intl.message(
      'Topics:',
      name: 'offer_details_label_topics',
      desc: '',
      args: [],
    );
  }

  /// `Enddate`
  String get offer_details_label_endDate {
    return Intl.message(
      'Enddate',
      name: 'offer_details_label_endDate',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get offer_details_button_label_accept {
    return Intl.message(
      'Accept',
      name: 'offer_details_button_label_accept',
      desc: '',
      args: [],
    );
  }

  /// `math`
  String get subject_math {
    return Intl.message(
      'math',
      name: 'subject_math',
      desc: '',
      args: [],
    );
  }

  /// `german`
  String get subject_german {
    return Intl.message(
      'german',
      name: 'subject_german',
      desc: '',
      args: [],
    );
  }

  /// `english`
  String get subject_english {
    return Intl.message(
      'english',
      name: 'subject_english',
      desc: '',
      args: [],
    );
  }

  /// `history`
  String get subject_history {
    return Intl.message(
      'history',
      name: 'subject_history',
      desc: '',
      args: [],
    );
  }

  /// `geography`
  String get subject_geography {
    return Intl.message(
      'geography',
      name: 'subject_geography',
      desc: '',
      args: [],
    );
  }

  /// `art`
  String get subject_art {
    return Intl.message(
      'art',
      name: 'subject_art',
      desc: '',
      args: [],
    );
  }

  /// `physical education`
  String get subject_physical_education {
    return Intl.message(
      'physical education',
      name: 'subject_physical_education',
      desc: '',
      args: [],
    );
  }

  /// `chemistry`
  String get subject_chemistry {
    return Intl.message(
      'chemistry',
      name: 'subject_chemistry',
      desc: '',
      args: [],
    );
  }

  /// `biologie`
  String get subject_biologie {
    return Intl.message(
      'biologie',
      name: 'subject_biologie',
      desc: '',
      args: [],
    );
  }

  /// `physics`
  String get subject_physics {
    return Intl.message(
      'physics',
      name: 'subject_physics',
      desc: '',
      args: [],
    );
  }

  /// `music`
  String get subject_music {
    return Intl.message(
      'music',
      name: 'subject_music',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}