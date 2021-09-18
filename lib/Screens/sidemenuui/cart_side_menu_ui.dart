import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/Screens/Cart.dart';

class CartSideMenu extends StatefulWidget {
  @override
  _CartSideMenuState createState() => _CartSideMenuState();
}

class _CartSideMenuState extends State<CartSideMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: AppBar(automaticallyImplyLeading: false,elevation: 0.0,
      backgroundColor: Color(0xffD4252F),title: Row(
        children: [
          GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child:DemoLocalizations.of(context).locale == Locale("en")
                  ? Icon(Icons.arrow_back_ios_rounded, size: 25, color:Colors.white)
                  : Icon(Icons.arrow_forward_ios_rounded,
                  size:25, color:Colors.white)),
          Expanded(
            child: Text(DemoLocalizations.of(context)
                .title['cart'],style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,),
          ),
        ],
      ),),
    body: Cart()),);
  }
}
