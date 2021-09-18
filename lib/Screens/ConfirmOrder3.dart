import 'package:flutter/material.dart';
import 'package:mishwar/app/Services/AddressServices.dart';
import '../main.dart';
import 'CartOrder.dart';
import 'CustomAppBar.dart';
import 'Addreses.dart';
import 'package:dotted_line/dotted_line.dart';
import 'GlobalFunction.dart';
import 'AddAddress.dart';
import '../Model/AddressModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:toast/toast.dart';
import 'package:mishwar/lang/app_Localization.dart';

 class ConfirmOrder3 extends StatefulWidget{
  int index;
  ConfirmOrder3(int index){
    this.index=index;
  }
  @override
  State<StatefulWidget> createState() {
 return _state(this.index);
  }
}
class _state extends State<ConfirmOrder3>{
  int index;
  _state(int index){
    this.index=index;
  }
  home h=new home();
  String payment;
  String delevery;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<AddressModel>addressList;
  AddressServices addressServices=new AddressServices();
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    addressList=await addressServices.GetAddresses(prefs.getString("UserId"));
    setState(() {
    });
   for(int i=0;i<addressList.length;i++){
     addressList[i].isPrimary=="1"?prefs.setString("address_id",  addressList[i].id):print("s");
   }
  }
  int selected=1;
  List <String>data=["5","5","5","5"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    List <Widget>content=[
      Container(
        padding: EdgeInsets.only(
          left:  MediaQuery.of(context).size.width*.05,
          right: MediaQuery.of(context).size.width*.05,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.08,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1000)),
                border: Border.all(color: Color(h.blueColor),width: 3),),
              padding: EdgeInsets.all(2),
              child: ClipRRect
                (
                borderRadius: BorderRadius.all(Radius.circular(5000)),
                child: FadeInImage.assetNetwork(
                  placeholder: "images/Photo.png",
                  image:home.userImag==null?"":home.userImag,
                  width: MediaQuery.of(context).size.width*.22,
                  height: MediaQuery.of(context).size.width*.22,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Divider(color: Colors.black26,thickness: 1,),
            SizedBox(height: 10,),
            Container(
              height:MediaQuery.of(context).size.height*.065,
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12.withOpacity(.05),width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.05),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*.3,
                    child: Text("الاسم",style: TextStyle(fontSize: 12),),
                  ),
                  Text(home.username,style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height:MediaQuery.of(context).size.height*.065,
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12.withOpacity(.05),width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.05),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*.3,
                    child: Text("رقم الهاتف",style: TextStyle(fontSize: 12)),
                  ),
                  Text(home.phone,textDirection: TextDirection.ltr,style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height:MediaQuery.of(context).size.height*.065,
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12.withOpacity(.05),width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.05),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*.3,
                    child: Text("البريد الالكتروني",style: TextStyle(fontSize: 12)),
                  ),
                  Text(home.email,style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            SizedBox(height: 25,),
          ],
        ),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child:  Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              data.length>0?GestureDetector(
                onTap: (){
                  Navigator.push(context, GlobalFunction.routeBottom(AddAddress("confirm")));
                },
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    color: Colors.black26,
                    strokeWidth: 1.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                          width: MediaQuery.of(context).size.width*.5,
                          height: MediaQuery.of(context).size.height*.06,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //  border: Border.all(width: 1.0,color: Colors.black26)
                            color: Color(h.blueColor)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/plus.png",width: 18,color: Colors.white,),
                              SizedBox(width:15),
                              Text("أضافة عنوان",style: TextStyle(fontSize: 12,color: Colors.white),),

                            ],
                          )
                      ),
                    )

                ),
              ):SizedBox(),
              SizedBox(height: MediaQuery.of(context).size.height*.02,),
              addressList==null?Expanded(child: Center(
                child: CircularProgressIndicator(),
              ),) :addressList.length>0?
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(
                        left:MediaQuery.of(context).size.width*.05-3,
                        right: MediaQuery.of(context).size.width*.05,
                        bottom: MediaQuery.of(context).size.height*.03
                    ),
                    itemCount: addressList.length,itemBuilder: (contect,index){
                  return Container(
                      child:Column(
                        children: [
                          GestureDetector(
                            onTap: ()async{

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(addressList[index].title,style: TextStyle(fontSize: 16),),
                                    Text(addressList[index].region,style: TextStyle(fontSize: 11,color: Colors.black87.withOpacity(.6)),),
                                    Text(addressList[index].address,style: TextStyle(fontSize: 11,color: Colors.black87.withOpacity(.6)),),
                                    Text("رقم هاتف : ${addressList[index].phone1}",style: TextStyle(fontSize: 11,color: Colors.black87.withOpacity(.6)),)
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                        onTap:()async{
                                          SharedPreferences pref=await SharedPreferences.getInstance();
                                            pref.setString("address_id",addressList[index].id);
                                          Map<String,dynamic>responce=await addressServices.SetPrimaryAddress(addressList[index].id);
                                          loadData();
                                          print(responce);
                                          setState(() {
                                            selected=index;
                                          });

                                        },
                                        child: addressList[index].isPrimary=="1"?Icon(Icons.check_circle,color: Colors.green,size: 38,):
                                        Container(
                                          width: 31,
                                          height: 31,
                                          margin: EdgeInsets.only(left: 3),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(1000)),
                                              border:Border.all(color: Colors.black26,width: 1)
                                          ),
                                        )
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                          Divider(color: Colors.black26,thickness: 1.5,)
                        ],
                      )
                  );
                }),
              )
                  :Expanded(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                      Image.asset("images/noAddress.png",
                        height: MediaQuery.of(context).size.height*.25,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                      Text("لم تقم باضافة عناوين بعد",style: TextStyle(fontSize: 12,color: Colors.black45),),
                      SizedBox(height: MediaQuery.of(context).size.height*.07,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.routeBottom(AddAddress("confirm")));
                        },
                        child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10),
                            color: Colors.black26,
                            strokeWidth: 1.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                  width: MediaQuery.of(context).size.width*.6,
                                  height: MediaQuery.of(context).size.height*.06,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //  border: Border.all(width: 1.0,color: Colors.black26)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("images/plus.png",width: 20,),
                                      SizedBox(width:10),
                                      Text("أضافة عنوان",style: TextStyle(fontSize: 12,color: Colors.black54),),

                                    ],
                                  )
                              ),
                            )

                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.05,),
          Container(
            width: MediaQuery.of(context).size.width*.25,
            height: MediaQuery.of(context).size.width*.25,
            child: Container(
                width: 25,height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                    border: Border.all(color: Color(h.blueColor),width: 3),
                    color: Colors.white
                ),
                padding: EdgeInsets.all(15),
                child:ImageIcon(AssetImage("images/inWay.png"),size: 35,color: Colors.black,)
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.0005,),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*.01,
                bottom: MediaQuery.of(context).size.height*.01,
                left: MediaQuery.of(context).size.width*.05,
                right: MediaQuery.of(context).size.width*.05
            ),

            alignment: Alignment.center,
            child: Text("طريقة التوصيل",style: TextStyle(fontSize:16),),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.02,),
          Container(
              height: 1,
            width:MediaQuery.of(context).size.width*.9,
            color: Colors.black26,
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.02,),
          Container(
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black12.withOpacity(.1),width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height*.02,
              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context, GlobalFunction.route(PaymentMethod()));
                      setState(() {
                        delevery = "delivery1";
                      });
                    },
                    child: Container(
                      height: 30,
                      // color: Colors.red,
                      child:Row(children: [
                        SizedBox(width: 10,),
                        Radio(
                          activeColor: Color(h.mainColor),
                          value: "delivery1",
                          groupValue: delevery,
                          onChanged: (String value) {
                            setState(() {
                              delevery=value;
                            });
                          },
                        ),Text("	استلام من الفرع",maxLines: 1,style: TextStyle(height: 1,color: Colors.black,fontSize: 12)),
                      ],)
                    ),
                  ),
                  SizedBox(height: 0,),
                  Divider(color: Colors.black12.withOpacity(.1),thickness: 1,),
                  SizedBox(height: 0,),
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                      setState(() {
                        delevery = "delivery2";
                      });
                    },
                    child: Container(
                      height: 30,
                      child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Radio(
                                activeColor: Color(h.mainColor),
                                value: "delivery2",
                                groupValue: delevery,
                                onChanged: (String value) {
                                  setState(() {
                                    delevery = value;
                                  });
                                },
                              ),
                            Text("توصيل من الفرع",maxLines: 1,style: TextStyle(color: Colors.black,fontSize: 12)),
                            ],
                             )


                    ),
                  ),
                  SizedBox(height: 0,),
                ],
              )
          ),
        ],
      ),
       Column(
         children: [
           SizedBox(height: MediaQuery.of(context).size.height*.05,),
           Container(
             width: MediaQuery.of(context).size.width*.25,
             height: MediaQuery.of(context).size.width*.25,
             child: Container(
                 width: 25,height: 25,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(1000)),
                     border: Border.all(color: Color(h.blueColor),width: 3),
                     color: Colors.white
                 ),
                 padding: EdgeInsets.all(15),
                 child:Icon(Icons.payment,color: Colors.black87,size: 55,)
             ),
           ),
           SizedBox(height: MediaQuery.of(context).size.height*.0005,),
           Container(
             padding: EdgeInsets.only(
                 top: MediaQuery.of(context).size.height*.01,
                 bottom: MediaQuery.of(context).size.height*.01,
                 left: MediaQuery.of(context).size.width*.05,
                 right: MediaQuery.of(context).size.width*.05
             ),

             alignment: Alignment.center,
             child: Text("طريقة الدفع",style: TextStyle(fontSize:16),),
           ),
           SizedBox(height: MediaQuery.of(context).size.height*.02,),
           Container(
             height: 1,
             width:MediaQuery.of(context).size.width*.9,
             color: Colors.black26,
           ),
           SizedBox(height: MediaQuery.of(context).size.height*.02,),
           //SizedBox(height: MediaQuery.of(context).size.height*.02,),
           Container(
               width: MediaQuery.of(context).size.width*.9,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(10)),
                 border: Border.all(color: Colors.black12.withOpacity(.1),width: 1),
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.withOpacity(0.1),
                     spreadRadius: 3,
                     blurRadius: 3,
                     offset: Offset(3, 3), // changes position of shadow
                   ),
                 ],
               ),
               padding: EdgeInsets.only(
                 bottom: MediaQuery.of(context).size.height*.02,
               ),
               child: Column(
                 children: [
                   SizedBox(height: 10,),
                   GestureDetector(
                     onTap: (){
                       // Navigator.push(context, GlobalFunction.route(PaymentMethod()));
                       setState(() {
                         payment = "payment1";
                       });
                     },
                     child: Container(
                         height: 30,
                         // color: Colors.red,
                         child:Row(children: [
                           SizedBox(width: 10,),
                           Radio(
                             activeColor: Color(h.mainColor),
                             value: "payment1",
                             groupValue: payment,
                             onChanged: (String value) {
                               setState(() {
                                 payment=value;
                               });
                             },
                           ),Text("الدفع عند الاستلام",maxLines: 1,style: TextStyle(height: 1,color: Colors.black,fontSize: 12)),
                         ],)
                     ),
                   ),
                   SizedBox(height: 0,),
                   Divider(color: Colors.black12.withOpacity(.1),thickness: 1,),
                   SizedBox(height: 0,),
                   GestureDetector(
                     onTap: (){
                       // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                       setState(() {
                         payment = "payment2";
                       });
                     },
                     child: Container(
                         height: 30,
                         child: Row(
                           children: [
                             SizedBox(width: 10,),
                             Radio(
                               activeColor: Color(h.mainColor),
                               value: "payment2",
                               groupValue: payment,
                               onChanged: (String value) {
                                 setState(() {
                                   payment = value;
                                 });
                               },
                             ),
                             Text("بواسطة بطاقة الائتمان",maxLines: 1,style: TextStyle(color: Colors.black,fontSize: 12)),
                           ],
                         )


                     ),
                   ),
                   SizedBox(height: 0,),
                 ],
               )
           ),
           SizedBox(height: MediaQuery.of(context).size.height*.02,),
         ],
       ),
       CartOrder()
    ];
 return SafeArea(
   child: Scaffold(appBar: AppBar(automaticallyImplyLeading: false,elevation: 0.0,
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
           child: Text(
//             DemoLocalizations.of(context)
//               .title['aboutApp']
            "متابعة الطلب" ,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
             textAlign: TextAlign.center,),
         ),
       ],
     ),),
     body:  Container(width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
         child: Column(
           children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
             Container(
               width: MediaQuery.of(context).size.width*.94,
                 height: MediaQuery.of(context).size.height*.06,

               child: Row(
                 children: [
                   Container(
                     width: MediaQuery.of(context).size.width*.1,
                     height: MediaQuery.of(context).size.width*.1,
                     padding: EdgeInsets.all(index>1?2:3),
                     child: Container(
                       width: 25,height: 25,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(1000)),
                         color: index>0?Color(h.blueColor):Colors.black26
                       ),
                       child:index>1?Icon(Icons.check,color: Colors.white,):Icon(Icons.person,color: Colors.white,size: 18,)
                     ),
                   ),
                   DottedLine(
                     direction: Axis.horizontal,
                     lineLength: MediaQuery.of(context).size.width*.11,
                     lineThickness: 2,
                     dashLength: 4.0,
                     dashColor: Colors.black54,
                     dashRadius: 0.0,
                     dashGapLength: 4.0,
                     dashGapColor: Colors.transparent,
                     dashGapRadius: 0.0,
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width*.1,
                     height: MediaQuery.of(context).size.width*.1,
                     padding: EdgeInsets.all(index>2?2:3),
                     child: Container(
                         width: 25,height: 25,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(1000)),
                             color: index>1?Color(h.blueColor):Colors.black26
                         ),
                         child:index>2?Icon(Icons.check,color: Colors.white,):Icon(Icons.location_on,color: Colors.white,size: 18,)
                     ),
                   ),
                   DottedLine(
                     direction: Axis.horizontal,
                     lineLength: MediaQuery.of(context).size.width*.11,
                     lineThickness: 2,
                     dashLength: 4.0,
                     dashColor: Colors.black54,
                     dashRadius: 0.0,
                     dashGapLength: 4.0,
                     dashGapColor: Colors.transparent,
                     dashGapRadius: 0.0,
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width*.1,
                     height: MediaQuery.of(context).size.width*.1,
                     padding: EdgeInsets.all(index>3?2:3),
                     child: Container(
                         width: 25,height: 25,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(1000)),
                             color: index>2?Color(h.blueColor):Colors.black26
                         ),
                         padding: EdgeInsets.all(4),
                         child:index>3?Icon(Icons.check,color: Colors.white,):ImageIcon(AssetImage("images/inWay.png"),size: 18,color: Colors.white,)
                     ),
                   ),
                   DottedLine(
                     direction: Axis.horizontal,
                     lineLength: MediaQuery.of(context).size.width*.11,
                     lineThickness: 2,
                     dashLength: 4.0,
                     dashColor: Colors.black54,
                     dashRadius: 0.0,
                     dashGapLength: 4.0,
                     dashGapColor: Colors.transparent,
                     dashGapRadius: 0.0,
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width*.1,
                     height: MediaQuery.of(context).size.width*.1,
                     padding: EdgeInsets.all(index>4?2:3),
                     child: Container(
                         width: 25,height: 25,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(1000)),
                             color: index>3?Color(h.blueColor):Colors.black26
                         ),
                         child:index>4?Icon(Icons.check,color: Colors.white,):Icon(Icons.payment,color: Colors.white,size: 18,)
                     ),
                   ),
                   DottedLine(
                     direction: Axis.horizontal,
                     lineLength: MediaQuery.of(context).size.width*.11,
                     lineThickness: 2,
                     dashLength: 4.0,
                     dashColor: Colors.black54,
                     dashRadius: 0.0,
                     dashGapLength: 4.0,
                     dashGapColor: Colors.transparent,
                     dashGapRadius: 0.0,
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width*.1,
                     height: MediaQuery.of(context).size.width*.1,
                     padding: EdgeInsets.all(2),
                     child: Container(
                         width: 25,height: 25,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(1000)),
                             color: index>4?Color(h.blueColor):Colors.black26
                         ),
                         child:Icon(Icons.check,color: Colors.white,)
                     ),
                   ),
                 ],
               ),
             ),
             Container(
               width: MediaQuery.of(context).size.width,
               child: Row(
                 children: [
                   SizedBox(width: MediaQuery.of(context).size.width*.01,),
                   Container(
                     width: MediaQuery.of(context).size.width*.17,
                         padding: EdgeInsets.only(right:  0),
                         child:Text("المستخدم",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                   ),
                   Container(
                       width: MediaQuery.of(context).size.width*.23,
                       padding: EdgeInsets.all(0),
                       child:Text("العنوان",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                   ),
                   Container(
                       width: MediaQuery.of(context).size.width*.17,
                       padding: EdgeInsets.all(0),
                       child:Text("التوصيل",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                   ),
                   Container(
                       width: MediaQuery.of(context).size.width*.26,
                       padding: EdgeInsets.all(0),
                       child:Text("الدفع",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                   ),
                   Container(
                       width: MediaQuery.of(context).size.width*.15,
                       padding: EdgeInsets.only(left: 0),
                       child:Text("التاكيد",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                   ),
                 ],
               ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.01,),
             Container(
               width: MediaQuery.of(context).size.width,
               height: 1,color: Colors.black26,
             ),
              Expanded(child: content[index-1]),
              index==5? SizedBox(): GestureDetector(
               onTap: ()async{
                        if(index==1){
                    setState(() {
                      index=index+1;
                    });
                   }
                   else if(index==2){
                     setState(() {
                       index=index+1;
                     });
                   }
                   else if(index==3){
                    if(delevery==null){
                      Toast.show(
                          "من فضلك اختر طريقة الشحن", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }else{
                      setState(() {
                        index=index+1;
                      });
                    }
                   }
                   else if(index==4){
                     if(payment==null){
                       Toast.show(
                           "من فضلك اختر طريقة الدفع", context,
                           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                     }else{
                       setState(() {
                         index=index+1;
                       });
                     }
                   }
               },
               child: Container(
                 width: MediaQuery.of(context).size.width*.9,
                 height: MediaQuery.of(context).size.height*.06,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(10)),
                   color: Color(h.blueColor)
                 ),
                 alignment: Alignment.center,
                 child: Text(index==5?"تاكيد":"التالي",style: TextStyle(color: Colors.white,fontSize: 16),),
               ),
             ),
             SizedBox(height: 20,)
           ],
         ),
       ),

   ),
 );
  }

}