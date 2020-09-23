// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

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

  /// `Please input your name and how to contact you (e.g. email.address).`
  String get onboaring_title {
    return Intl.message(
      'Please input your name and how to contact you (e.g. email.address).',
      name: 'onboaring_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get onboarding_textfield_label_name {
    return Intl.message(
      'Name',
      name: 'onboarding_textfield_label_name',
      desc: '',
      args: [],
    );
  }

  /// `How to contact you`
  String get onboarding_textfield_label_contact {
    return Intl.message(
      'How to contact you',
      name: 'onboarding_textfield_label_contact',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get onborading_textfield_error_name_empty {
    return Intl.message(
      'Please enter your name',
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

  /// `Please enter how to contact you`
  String get onborading_textfield_error_contact_empty {
    return Intl.message(
      'Please enter how to contact you',
      name: 'onborading_textfield_error_contact_empty',
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