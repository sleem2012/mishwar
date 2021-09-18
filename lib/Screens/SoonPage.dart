import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SoonPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _state();
  }
}
class _state extends State<SoonPage>{
  @override
  Widget build(BuildContext context) {
   return   Center(
       child:Column(
         children: [
           SizedBox(height: MediaQuery.of(context).size.height*.18,),
           Image.asset("images/logo.png",
            height: MediaQuery.of(context).size.height*.25,
           ),
           Text("ترقبوا قريبا",style: TextStyle(
           shadows: [
             Shadow(
               blurRadius: 10.0,
               color: Colors.black12,
               offset: Offset(1.0, 1.0),
             ),
           ],fontSize: 35,color: Colors.black38),)
         ],
       ),
     )
    ;
  }
}