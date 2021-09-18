import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'CustomAppBar.dart';
import '../main.dart';
import 'package:mishwar/Screens/myDrawer.dart';
class PaymentMethod extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PaymentMethodState();
  }

}
class PaymentMethodState extends State<PaymentMethod>{
  home h=new home();
  List<String> current =["Visa Card","PayPal"];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String currentMoney;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentMoney=current[0];
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
      //  endDrawer: MyDrawer(-1),

       // resizeToAvoidBottomPadding: false,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: EdgeInsets.only(
                  //right: MediaQuery.of(context).size.width*.04,
                  //left: MediaQuery.of(context).size.width*.04,
                  //top: MediaQuery.of(context).size.height*.03
              ),
              children: [
                 CustomAppBar(DemoLocalizations.of(context).title['paymentmethods'] , ),
              /*  Container(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*.03,top: MediaQuery.of(context).size.height*.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){Navigator.pop(context);},
                        ),
                        InkWell(
                          child: Text("Edit",style: TextStyle(color:Colors.red,fontSize: 15),),
                        ),


                      ],
                    )
                ),*/
       Container(
         padding: EdgeInsets.only(
           right: MediaQuery.of(context).size.width*.05,
           left: MediaQuery.of(context).size.width*.05,
           //top: MediaQuery.of(context).size.height*.03
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            // SizedBox(height: MediaQuery.of(context).size.height*.05,),
           //  Text("Payment Method",style: TextStyle(fontSize: 22),),
             SizedBox(height: MediaQuery.of(context).size.height*.025,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black12.withOpacity(.03),width: 1),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                 height: MediaQuery.of(context).size.height*.1,

                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Container(
                         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.04,
                           right: MediaQuery.of(context).size.width*.04,),
                         child: Image.asset("images/Bitmap1.png",width: MediaQuery.of(context).size.width*.17,height: MediaQuery.of(context).size.height*.07,)
                     ),
                     Container(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("**** **** *112",style: TextStyle(fontSize: 14,),),
                           Text("may 05,2020",style: TextStyle(fontSize: 12,),),
                         ],
                       ),
                     ),

                   ],
                 ),
               ),
            SizedBox(height:MediaQuery.of(context).size.height*.015 ,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black12.withOpacity(.03),width: 1),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                 height: MediaQuery.of(context).size.height*.1,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Container(
                         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.04,
                           right: MediaQuery.of(context).size.width*.04,),
                         child: Image.asset("images/Bitmap2.png",width: MediaQuery.of(context).size.width*.17,height: MediaQuery.of(context).size.height*.07,)),
                     Container(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("**** **** *112",style: TextStyle(fontSize: 14,),),
                           Text("may 05,2020",style: TextStyle(fontSize: 12,),),
                         ],
                       ),
                     ),

                   ],
                 ),
               ),

             SizedBox(height: MediaQuery.of(context).size.height*.05,),
             Text("أضافة طريقة دفع جديده",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
               height: MediaQuery.of(context).size.height*.07,
               decoration: BoxDecoration(
                 borderRadius:BorderRadius.all(Radius.circular(10)),
                 border: Border.all(color: Color(h.borderColor),width: 1),
                 color: Colors.white,
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Container(
                       padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.03,
                         right: MediaQuery.of(context).size.width*.04,),
                       child: Image.asset("images/Bitmap1.png",width: MediaQuery.of(context).size.width*.17,height: MediaQuery.of(context).size.height*.07,)
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width*.65,


                     padding: EdgeInsets.only(
                       left: MediaQuery.of(context).size.width*.03,
                       right: MediaQuery.of(context).size.width*.03,
                     ),
                     child: DropdownButtonFormField<String>(
                       decoration: InputDecoration(
                           enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(style: BorderStyle.none))),
                       elevation: 0,
                       value: currentMoney,
                       onChanged: (String Value) {
                         setState(() {
                           currentMoney = Value;
                         });
                       },
                       items: current.map((String user) {
                         return  DropdownMenuItem<String>(
                           value: user,
                           child: Text(currentMoney, style:  TextStyle(color: Colors.black54),),
                         );
                       }).toList(),
                     ),


                   ),



                 ],
               ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
               height: MediaQuery.of(context).size.height*.07,
               decoration: BoxDecoration(
                 borderRadius:BorderRadius.all(Radius.circular(10)),
                 color: Colors.white,
               ),
               child: TextFormField(
                 keyboardType: TextInputType.number,
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                   enabledBorder: new OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide(color: Color(h.borderColor))
                   ),
                   focusedBorder:  new OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide(color: Color(h.FocusBorderColor))
                   ),
                   focusedErrorBorder:new OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20),
                       borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                   ),
                   errorBorder:new OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                   ),
                   hintText: 'Card Number',
                   hintStyle: TextStyle(color: Colors.black54)
                 ),
                 controller: null,
               ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Container(
                   width: MediaQuery.of(context).size.width*.4,
                   height: MediaQuery.of(context).size.height*.07,
                   decoration: BoxDecoration(
                     borderRadius:BorderRadius.all(Radius.circular(10)),
                     border: Border.all(color: Color(h.borderColor),width: 1),
                     color: Colors.white,
                   ),

                   padding: EdgeInsets.only(
                     left: MediaQuery.of(context).size.width*.03,
                     right: MediaQuery.of(context).size.width*.03,
                   ),
                   child: DropdownButtonFormField<String>(
                     decoration: InputDecoration(
                         enabledBorder: UnderlineInputBorder(
                             borderSide: BorderSide(style: BorderStyle.none))),
                     elevation: 0,
                     value: currentMoney,
                     onChanged: (String Value) {
                       setState(() {
                         currentMoney = Value;
                       });
                     },
                     items: current.map((String user) {
                       return  DropdownMenuItem<String>(
                         value: user,
                         child: Text(currentMoney, style:  TextStyle(color: Colors.black54),),
                       );
                     }).toList(),
                   ),


                 ),
                 Container(
                   width: MediaQuery.of(context).size.width*.4,
                   height: MediaQuery.of(context).size.height*.07,
                   decoration: BoxDecoration(
                     borderRadius:BorderRadius.all(Radius.circular(10)),
                     color: Colors.white,
                   ),
                   child: TextFormField(
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                       enabledBorder: new OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(color: Color(h.borderColor))
                       ),
                       focusedBorder:  new OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(color: Color(h.FocusBorderColor))
                       ),
                       focusedErrorBorder:new OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20),
                           borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                       ),
                       errorBorder:new OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                       ),
                       hintText: 'Cvv',
                       hintStyle: TextStyle(color: Colors.black54)
                     ),
                     controller: null,
                   ),
                 ),
               ],
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.04,),
             Container(
               decoration:BoxDecoration(
                 borderRadius: BorderRadius.circular(10),color: Color(h.blueColor),),
               height: MediaQuery.of(context).size.height*.065,
               width: MediaQuery.of(context).size.width*.9,
               child:   FlatButton(
                 child: Text("تـأكيد",style: TextStyle(color:Colors.white,fontSize: 16),),
                 onPressed:null,),
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