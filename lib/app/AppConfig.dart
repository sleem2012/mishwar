import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mishwar/controllers/app.controller.dart';
import 'package:mishwar/controllers/app.data.controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/ProductServices.dart';

class AppConfig
{
  SharedPreferences _prefs;
  final CApp _cApp = CApp();
  final DApp _dApp = DApp();

  // --- getters > controllers --- //
  CApp get cApp => _cApp;
  DApp get dApp => _dApp;
  SharedPreferences get prefs => _prefs;
  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    _prefs = await SharedPreferences.getInstance();
    productServices.getCategory();

    productServices.getProduct('1', '1');
   // productServices.GetProduct('1', '1');
   // productServices.GetSubProduct('1');getProduct

   }
}
AppConfig appConfig = AppConfig();

