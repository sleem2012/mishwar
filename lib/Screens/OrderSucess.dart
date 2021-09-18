import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:mishwar/lang/app_Localization.dart';

class OrderSuccess extends StatefulWidget{
  int quantity;
  int order_id;
  double subtotal;
  double total;
  double tax;
  OrderSuccess(int quantity,int order_id,double subtotal,double totle,double tax){
    this.quantity=quantity;
    this.order_id=order_id;
    this.subtotal=subtotal;
    this.total=totle;
    this.tax=tax;
  }
  @override
  State<StatefulWidget> createState() {
  return _state(this.quantity,this.order_id,this.subtotal,this.total,this.tax);
  }
}
class _state extends State<OrderSuccess>{
  int quantity;
  int order_id;
  double subtotal;
  double total;
  double tax;
  _state(int quantity,int order_id,double subtotal,double totle,double tax){
    this.quantity=quantity;
    this.order_id=order_id;
    this.subtotal=subtotal;
    this.total=totle;
    this.tax=tax;
  }
  home h=new home();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width:  MediaQuery.of(context).size.width,
            child:Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.03,),
               Icon(Icons.check_circle,size: 150,color: Color(h.blueColor),),
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Text(DemoLocalizations.of(context)
                    .title['operationaccomplishedsuccessfully']
                  ,style: TextStyle(color: Color(h.blueColor),fontSize: 25,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
                SizedBox(height: MediaQuery.of(context).size.height*.025,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black12,width: 1),
                    color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*.9,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                            color: Colors.grey.withOpacity(.3)
                        ),
                        alignment: Alignment.center,
                        child: Text(DemoLocalizations.of(context)
                            .title['requestdetails'],style:TextStyle(fontSize: 16),),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*.05,
                          right: MediaQuery.of(context).size.width*.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text(DemoLocalizations.of(context)
                                        .title['requestnumber'],style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(order_id.toString(),style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(DemoLocalizations.of(context)
                                        .title['qunt'],style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(quantity.toString(),style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),

                              ],
                            ),

                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(DemoLocalizations.of(context)
                                        .title['Paymentcosts'],style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("00.0"+' '+DemoLocalizations.of(context)
                                        .title['currency'],textDirection: TextDirection.rtl,style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    //
                                    Text(DemoLocalizations.of(context)
                                        .title['DeliveryCharge'],style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("00.0"+' '+DemoLocalizations.of(context)
                                        .title['currency'],textDirection: TextDirection.rtl,style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(DemoLocalizations.of(context)
                                        .title['taxcosts'],style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(((tax).toStringAsFixed(2)).toString()+' '+DemoLocalizations.of(context)
                                        .title['currency'],textDirection: TextDirection.rtl,style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    //Productsprice
                                    Text(DemoLocalizations.of(context)
                                        .title['Productsprice'],style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      //color: Colors.black26,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(((subtotal).toStringAsFixed(2)).toString()+' '+DemoLocalizations.of(context)
                                        .title['currency'],textDirection: TextDirection.rtl,style: TextStyle(fontSize: 12),),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.37,
                                      height: 1,
                                      //color: Colors.black26,
                                    )
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 5,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.03,),
                Text(DemoLocalizations.of(context)
                    .title['Total']+" ${total} "+DemoLocalizations.of(context)
                    .title['currency'],textDirection: TextDirection.rtl,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: MediaQuery.of(context).size.height*.03,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:(){
                        Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom:MediaQuery.of(context).size.height*.03),
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10),color: Color(h.mainColor),),
                          height: MediaQuery.of(context).size.height*.06,
                          width: MediaQuery.of(context).size.width*.43,
                          alignment: Alignment.center,
                          child:    Text(DemoLocalizations.of(context)
                              .title['main'],style: TextStyle(color:Colors.white,fontSize: 15),),

                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                         Navigator.pushNamedAndRemoveUntil(context, "/Orders", (route) => false);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom:MediaQuery.of(context).size.height*.03),
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10),color: Color(h.blueColor),),
                          height: MediaQuery.of(context).size.height*.06,
                          width: MediaQuery.of(context).size.width*.43,
                          alignment: Alignment.center,
                        //  ظظmyorders
                          child:    Text(DemoLocalizations.of(context)
                              .title['myorders'],style: TextStyle(color:Colors.white,fontSize: 15),),

                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}