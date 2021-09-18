import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationDone extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<VerificationDone>{
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), (){
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/mainPage',
              (Route<dynamic> route) => false);
      // Phoenix.rebirth(context);
    });
    return Scaffold(
      body: Container(
        height:MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/checked.png",width: MediaQuery.of(context).size.width*.50,),
              SizedBox(height: MediaQuery.of(context).size.height*.035,),
              Text("تـم تـفعيل الحساب بنجاح",style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold),),

            ],
          ),
        ),
      ),
    );
  }
}