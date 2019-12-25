import 'package:flutter/material.dart';

class LocaleState extends ChangeNotifier {
  Locale _locale;//主题
  LocaleState(this._locale);

  factory LocaleState.zh()=> LocaleState(Locale('zh', 'CH'));

  factory LocaleState.en()=> LocaleState(Locale('en', 'US'));

  void changeLocaleState(LocaleState state){
    _locale=state.locale;
    notifyListeners();
  }

  Locale get locale => _locale; //获取语言
}