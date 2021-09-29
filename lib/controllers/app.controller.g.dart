// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CApp on _CApp, Store {
  final _$appLocaleAtom = Atom(name: '_CApp.appLocale');

  @override
  Locale get appLocale {
    _$appLocaleAtom.reportRead();
    return super.appLocale;
  }

  @override
  set appLocale(Locale value) {
    _$appLocaleAtom.reportWrite(value, super.appLocale, () {
      super.appLocale = value;
    });
  }

  final _$_CAppActionController = ActionController(name: '_CApp');

  @override
  dynamic initLocal() {
    final _$actionInfo =
        _$_CAppActionController.startAction(name: '_CApp.initLocal');
    try {
      return super.initLocal();
    } finally {
      _$_CAppActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeLanguage(Locale locale,BuildContext context) async{
    final _$actionInfo =
        _$_CAppActionController.startAction(name: '_CApp.changeLanguage');
    try {
      return super.changeLanguage(locale,context);
    } finally {
      _$_CAppActionController.endAction(_$actionInfo);

    }

  }

  @override
  String toString() {
    return '''
appLocale: ${appLocale}
    ''';
  }
}
