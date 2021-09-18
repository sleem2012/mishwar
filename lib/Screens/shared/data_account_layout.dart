import 'package:flutter/material.dart';
class DataAccountLayout extends StatelessWidget {
  final String title1;
  final String title2;

  const DataAccountLayout({Key key, this.title1, this.title2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start
        ,mainAxisAlignment: MainAxisAlignment.start,children: [
        Expanded(flex: 2,
          child: Text(title1,style: TextStyle(color: Colors.grey,
              fontSize: 10.0),),
        ),
        SizedBox(width:5.0,),
        Expanded(flex: 4,child: Text(title2,textAlign: TextAlign.start
          ,style: TextStyle(color: Colors.black.withOpacity(0.75),fontSize:12.0 ),)),
        // Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 10.0,)
      ],),padding: EdgeInsets.only(left:6.0,right: 6.0,top: 12.0,bottom: 12.0),decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 3,
            blurRadius: 7,
            offset:
            Offset(0, 3), // changes position of shadow
          ),
        ],color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),border: Border.all(width: 1.0,
        color: Colors.grey.withOpacity(0.25))),);
  }
}
