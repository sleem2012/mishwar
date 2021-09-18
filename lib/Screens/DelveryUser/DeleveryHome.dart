import 'package:flutter/material.dart';
import 'package:mishwar/Screens/Notifications.dart';
import '../../main.dart';
import '../GlobalFunction.dart';
import 'DeliverNotification.dart';
import 'HomeDeliveryOrders.dart';
import 'DeleveryDrawer.dart';
import 'DeleveryMain.dart';
import 'DeliveryProfile.dart';
import 'package:mishwar/lang/app_Localization.dart';


class DeleveryHome extends StatefulWidget {
  int index;

  @override
  _State createState() => _State( );
}
class _State extends State<DeleveryHome> {
  int _currentIndex=0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  home h=new home();
  List<Widget>itemsUi=[
    DeleveryMainPage(),
    HomeDeliveryOrders(),
    DeliverNotifications(),
    DeliveryProfile(),



  ];
  List<String>titles=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    titles= [ DemoLocalizations.of(context)
        .title['main'],   DemoLocalizations.of(context)
        .title['orders'],

      DemoLocalizations.of(context)
          .title['notifications'], DemoLocalizations
          .of(context)
          .title['account'],


    ];
    return  SafeArea(
      child: Scaffold(
        drawer: DeleveryDrawer(_currentIndex),
         key: _scaffoldKey,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*.07,
                  width: MediaQuery.of(context).size.width,
                  color: Color(h.mainColor),
                  padding: EdgeInsets.only(
                    left:MediaQuery.of(context).size.width*.05,
                    right: MediaQuery.of(context).size.width*.05,

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                            _scaffoldKey.currentState.openDrawer();
                          },
                          child: Container(
                              padding: EdgeInsets.all(2),
                              child: ImageIcon(AssetImage("images/icon/menu.png"),size: 22,color: Colors.white,))),
                      Text( titles[_currentIndex],style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, GlobalFunction.routeBottom(Notifications()));
                          },
                          child: Container(
                              padding: EdgeInsets.all(2),
                              child: ImageIcon(AssetImage("images/icon/notification.png"),size: 22,color: Color(h.mainColor),)))
                    ],
                  ),
                ),
                itemsUi[_currentIndex]
              ],
            ),
          ),


        bottomNavigationBar:
        BottomNavigationBar(
            elevation: 15.5,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.red,
            selectedFontSize: 12,
            unselectedItemColor: Colors.black45,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                // print('${index}index');
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon:ImageIcon(AssetImage("images/icon/home.png"),size: 18,),
                  title:  Text( DemoLocalizations.of(context)
                      .title['main'],style: TextStyle(height: 1.75,fontSize: 10,),)),
              BottomNavigationBarItem(
                  icon:  ImageIcon(AssetImage("images/icon/order.png"),size: 18,),
                  title: Text( DemoLocalizations.of(context)
                      .title['orders'],style: TextStyle(height: 1.75,fontSize: 10,),)),
              BottomNavigationBarItem(
                  icon:  ImageIcon(AssetImage("images/icon/NotificationIcon.png"),size: 18,),
                  title: Text( DemoLocalizations.of(context)
                      .title['notifications'],style: TextStyle(height: 1.75,fontSize: 10,),)),
              BottomNavigationBarItem(
                  icon:ImageIcon(AssetImage("images/icon/user.png"),size: 18,),
                  title:  Text(DemoLocalizations.of(context)
                      .title['account'],style: TextStyle(height: 1.75,fontSize: 10,),)),











            ]),




      ),
    );
  }
}