import 'package:flutter/material.dart';
import 'package:mishwar/app/AppConfig.dart';
import 'package:mobx/mobx.dart';

part 'app.controller.g.dart';

class CApp = _CApp with _$CApp;

abstract class _CApp with Store{
  @observable
  Locale appLocale=Locale('ar');

  @action
  initLocal() {
     appLocale =appConfig.prefs.containsKey('lang')?
    appConfig.prefs.getString('lang')!=null?Locale(appConfig.prefs.getString('lang')): Locale('ar'): Locale('ar');
     print('${appLocale},,,,,,,,applocale');
     print('${appConfig.prefs.getString('lang')},,,,,from shared pref');
  }
  @action
  changeLanguage(Locale locale)
  {
    appLocale=locale;
    appConfig.prefs.setString('lang', locale.toString());

  }
}