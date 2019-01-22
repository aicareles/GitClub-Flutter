import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);
class APPLIC {
  // 支持的语言列表
  final List<String> supportedLanguages = ['en','zn'];

  // 支持的Locales列表
  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  // 当语言改变时调用的方法
  LocaleChangeCallback onLocaleChanged;

  ///
  /// Internals
  ///
  static final APPLIC _applic = new APPLIC._internal();

  factory APPLIC(){
    return _applic;
  }

  APPLIC._internal();
}

APPLIC applic = new APPLIC();