
import 'package:flutter/material.dart';
class ButtonUi extends StatelessWidget {
  final Color backColor;
  final Function function;
  final double doubleValue;
  final Widget widget;

  const ButtonUi({Key key, this.backColor, this.function, this.doubleValue, this.widget}) : super(key: key);






  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      function();
    },
      child: Container(padding: EdgeInsets.only(top: 10.0,bottom:10.0),alignment: Alignment.center,
        child:widget ,width: doubleValue,
        decoration: BoxDecoration(color: backColor,
            borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
