import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:mishwar/Screens/Splash.dart';
import 'package:mishwar/app/AppConfig.dart';
// import 'package:google_map_location_picker/generated/l10n.dart' as location_picker;

import 'Screens/Addreses.dart';

import 'Screens/HomePage.dart';
import 'Screens/LanguageUi.dart';
import 'Screens/Register.dart';
 import 'Screens/Slider.dart';
import 'Screens/Verification.dart';
import 'Screens/VerificationDone.dart';
import 'Screens/login.dart';
import 'Screens/Orders.dart';

import 'Screens/DelveryUser/DeleveryHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/ready_ui.dart';
import 'lang/app_LocalizationDeledate.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Screens/DelveryUser/DeliveryOrders.dart';
import 'test_ui.dart';
Future<void> main() async {
  await appConfig.init();
  await appConfig.cApp.initLocal();
   runApp(ParentPage());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
class home extends StatelessWidget{
  int mainColor=0xffD4252F;
  int blueColor=0xff55b866;
  int bgColor=0xfff1fbf7;
  int borderColor=0xffe7e7e7;
  int FocusBorderColor=0xfffccfcc;
  int ErorrBorderColor=0xfff00f00;
  int whiteColor=0xffF7F9FC;
  static String username;
  static String phone;
  static String userImag;
  static String email;

  @override
  Widget build(BuildContext context) {
    return  Observer(builder: (_)=>MaterialApp(
      localizationsDelegates: [
        // location_picker.S.delegate,
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", ""), // OR Locale('ar', 'AE') OR Other RTL locales
        Locale("ar", ""),
      ], locale: appConfig.cApp.appLocale,
      theme:ThemeData(
      primaryColor: Color(blueColor),
        fontFamily: 'mishwarfont',
        accentColor: Color(0xff55b866),
      ),
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        '/slider':(BuildContext context)=>new slider(),
        '/login':(BuildContext context)=>new login("home"),
        '/Register':(BuildContext context)=>new Register(),
        '/Adresses':(BuildContext context)=>new Adresses(),
        '/Orders':(BuildContext context)=>new Orders(),
        '/verification':(BuildContext context)=>new verification("",""),
        '/mainPage':(BuildContext context)=>new HomePage( ),
        '/DeleverMain':(BuildContext context)=>new DeleveryHome(),
        '/DeliveryOrders':(BuildContext context)=>new DeliveryOrders(),
        '/Cart':(BuildContext context)=>new HomePage( ),
        '/fav':(BuildContext context)=>new HomePage( ),
        '/VerificationDone':(BuildContext context)=>new VerificationDone(),
        '/LanguageUi':(BuildContext context)=>  LanguageUi(),

       },
      home:
      //Ready_UI()
      //TestUI()
      //ChooseBranch()
      Splash(),
    ));
  }
}
class ParentPage extends StatefulWidget {
   static String userType;
  static int counter;
  static String address;
   @override
  _State createState() => _State();
}
class _State extends State<ParentPage>
{

  String _message = '';
  String _tokenAccess='';
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =new  FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging =new  FirebaseMessaging();
  _register()async {
    await _firebaseMessaging.getToken().then((token){
      SharedPreferences.getInstance().then((shared){
        shared.setString('token', token);
      });

      print('${token},,,,,,toookkk');
    });
    print("_____________________________________________________________________________________________________________");
  }
  void getMessage()async{
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          showNotificationsFunc(message);
          print('on message $message');
          setState(() => _message = message["notification"]["title"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"]);
    });
  }
  showNotificationsFunc(Map<String,dynamic>message)async
  {
    var android = AndroidNotificationDetails('channel_id', 'CHANNEL_NAME', 'channelDescription');
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.show(0, message['notification']['title'].toString(),
        message['notification']['body'].toString(), platform);
  }
  @override
  void initState() {
    // TODO: implement initState
    //  secureScreen();
    super.initState();
   var android = new AndroidInitializationSettings('mipmap/launcher_icon');
    var ios = IOSInitializationSettings();
    var platform = InitializationSettings(android,ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    getMessage();
    _register();
   }
  @override
  Widget build(BuildContext context) {
    return home();
  }
}
