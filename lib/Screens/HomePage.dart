import 'package:flutter/material.dart';
import 'package:mishwar/Screens/Notifications.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'GlobalFunction.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import 'Branches.dart';
import '../main.dart';
import 'Cart.dart';
import 'Favourite.dart';
import 'SoonPage.dart';
import 'mainPage.dart';
 class HomePage extends StatefulWidget {
   static String UserId;

  @override
  _State createState() => _State();
}
class _State extends State<HomePage> {
  int _currentIndex=0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  home h=new home();
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      HomePage.UserId=prefs.getString("UserId");
    });
  }
  List<Widget>itemsUi=[
    MainPage(),
    Expanded(child: SoonPage()),
    Expanded(child: Cart()),
    Expanded(child: Favourite()),
    Expanded(child: Branches()),
  ];
  List<String>titles=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    titles= [ DemoLocalizations.of(context)
        .title['main'],   DemoLocalizations.of(context)
        .title['Offers'],

      DemoLocalizations.of(context)
          .title['cart'], DemoLocalizations.of(context)
          .title['favorite'],
      DemoLocalizations.of(context)
          .title['branches'],

    ];
    //Observer
    return   SafeArea(
          child: Scaffold(
            drawer: MyDrawer(),
            // backgroundColor: Color(h.mainColor),
            key: _scaffoldKey,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*.07,
                    width: MediaQuery.of(context).size.width,
                    color:  Color(h.mainColor),
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
                        Text(titles[_currentIndex] ,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, GlobalFunction.routeBottom(Notifications()));
                            },
                            child: Container(
                                padding: EdgeInsets.all(2),
                                child: ImageIcon(AssetImage("images/icon/notification.png"),size: 22,color: Colors.white,)))
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
                      title:  Text(DemoLocalizations.of(context)
                          .title['main']
                        ,style: TextStyle(height: 1.75,fontSize: 10,),)),
                  BottomNavigationBarItem(
                      icon:  ImageIcon(AssetImage("images/offerIcon.png"),size: 18,),
                      title: Text(DemoLocalizations.of(context)
                          .title['Offers']
                        ,style: TextStyle(height: 1.75,fontSize: 10,),)),
                  BottomNavigationBarItem(
                      icon:  ImageIcon(AssetImage("images/icon/cart_bar.png"),size: 18,),
                      title: Text(DemoLocalizations.of(context)
                          .title['cart']
                        ,style: TextStyle(height: 1.75,fontSize: 10,),)),
                  BottomNavigationBarItem(
                      icon:  Icon(Icons.star_border,size: 24,),
                      title: Text(DemoLocalizations.of(context)
                          .title['favorite']
                        ,style: TextStyle(height: 1.75,fontSize: 10,),)),
                  BottomNavigationBarItem(
                      icon:ImageIcon(AssetImage("images/icon/location.png"),size: 18,),
                      title:  Text(DemoLocalizations.of(context)
                          .title['branches']
                        ,style: TextStyle(height: 1.75,fontSize: 10,),)),












                ]),




          ),
        )
     ;

  }
}