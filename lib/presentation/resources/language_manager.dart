import 'package:flutter/material.dart';

enum LanguageType { english, spanish }

const String spanish = 'es';
const String english = 'en';
const spanishLocal = Locale('es');
const englishLocal = Locale('en');

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.spanish:
        return spanish;
    }
  }
}
