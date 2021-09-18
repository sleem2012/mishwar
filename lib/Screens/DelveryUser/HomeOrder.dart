import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mishwar/app/Services/OrderServices.dart';
import '../GlobalFunction.dart';
import 'package:mishwar/Screens/HomePage.dart';
import '../../main.dart';
import 'DeliveryOrderDetail.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import '../CustomAppBar.dart';
 import '../../Model/OrderStatusModel.dart';
import '../../Model/OrderDeliveryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class  HomeOrders extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<HomeOrders>{
  String SelectedCategory;
  home h=new home();
  int index=0;
  List<String>data=["","",""];
  OrderServices orderServices=new OrderServices();
  List<OrderStatusDetail>orderStatus=[];
  List<DeliveryOrderDetail>orders;
  loadData()async{
    orderStatus=await orderServices.GetOrderStatusDelevery();
    setState(() {
      SelectedCategory=orderStatus[0].id;
    });
    getOrder(orderStatus[0].id);
  }
  getOrder(var status_id)async{
    orders==null;
    setState(() {
    });
    SharedPreferences prefs=await SharedPreferences.getInstance();
    orders=await orderServices.GetOrdersDelivery(prefs.getString("driver_id"), status_id);
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget>content=[
      Expanded(child: ListView.builder(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height*.025,
              bottom: MediaQuery.of(context).size.height*.03
          ),
          itemCount: 10,itemBuilder: (context,index){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height*.12,
          margin: EdgeInsets.only(
              bottom:MediaQuery.of(context).size.height*.01,
              left: MediaQuery.of(context).size.width*.03,
              right:  MediaQuery.of(context).size.width*.03
          ),
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*.02,
          ),
          child: Row(
            children: [
              Image.asset("images/food.png",
                width: MediaQuery.of(context).size.width*.25,
                height: MediaQuery.of(context).size.height*.12,
                fit: BoxFit.cover,
              ),
              SizedBox(width:MediaQuery.of(context).size.width*.02,),
              Container(
                width: MediaQuery.of(context).size.width*.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.height*.005,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("وجبة عائلية",style: TextStyle(height: .7,color: Color(h.mainColor),fontSize: 17,fontWeight: FontWeight.bold),),
                        Row(children: [
                          Icon(Icons.bookmark,color: Color(h.blueColor),),
                        ],)
                      ],
                    ),
                    Text("هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق،",
                      style: TextStyle(height: 1.0,fontSize: 11,color: Colors.black38),maxLines: 2,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height*.01,),
                  ],),
              )
            ],
          ),
        );
      })),
    ];
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Expanded(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.07,
                child:  Container(
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
                            Navigator.pushNamedAndRemoveUntil(context, "/DeleverMain", (route) => false);
                          },
                          child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 25,)),
                      Text("الطلبات",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                      GestureDetector(
                          onTap: (){
                          },
                          child: Icon(Icons.arrow_forward_outlined,color: Color(h.mainColor),size: 25,))
                    ],
                  ),
                ),

              ),
              Container(
                height: 26+MediaQuery.of(context).size.height*.025,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*.015,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: orderStatus.length,
                    itemBuilder: (context,index)
                    {
                      return GestureDetector(
                        onTap: (){
                          getOrder(orderStatus[index].id);
                          setState(() {
                            SelectedCategory=orderStatus[index].id;
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.only(
                              right:index==0?MediaQuery.of(context).size.width*.05:0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 0,),
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text(orderStatus[index].name,maxLines: 1,style: TextStyle(color: SelectedCategory==orderStatus[index].id?Color(h.mainColor):Colors.black54,fontSize: 14),textAlign: TextAlign.center,)),
                                    SizedBox(width: MediaQuery.of(context).size.width*.06,),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                /* Container(
                                width:  80,
                                height: 4,
                                color: Colors.black12.withOpacity(.05),
                              )*/
                                /*  SelectedCategory==Category[index]?  Container(height:2,color: Color(h.mainColor),
                                  width: 90,
                                ):SizedBox()*/

                              ],
                            )        ),
                      );
                    }
                ),
              ),
              orders==null?Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ):orders.length>0?
              Expanded(child: ListView.builder(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*.0,
                      bottom: MediaQuery.of(context).size.height*.04
                  ),
                  itemCount: orders.length,itemBuilder: (context,index){
                return   GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(DeliveryOrderDetails(orders[index])));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.01,right:  MediaQuery.of(context).size.width*.05,left:  MediaQuery.of(context).size.width*.05,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black12.withOpacity(.08),width: 1),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.03),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                            width:MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              right: 10,
                              top: MediaQuery.of(context).size.height*.015,
                              bottom: MediaQuery.of(context).size.height*.01,
                              left:0,
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(

                                    children: [
                                      Image.asset("images/logo.png",
                                        //width:  MediaQuery.of(context).size.width*.3,
                                        height:MediaQuery.of(context).size.height*.12 ,
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(" طلب رقم "+orders[index].orderNumber,style: TextStyle(height: 1.5,fontSize: 14,fontWeight: FontWeight.bold,color: Color(h.mainColor)),),
                                          SizedBox(height: 3,),
                                          Text(" عدد المنتجات  ${orders[index].orderDetails.length}",style: TextStyle(height: 1.5,fontSize: 13,color: Colors.black38)),
                                          SizedBox(height: 3,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*.64-10,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(" الاجمالي   ${orders[index].totalValue} ريال ",style: TextStyle(fontSize: 13),),
                                              ],
                                            ),
                                          )
                                        ],
                                      )


                                    ],),
                                ),
                                /* Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                  ],
                                ),
                                   Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [



                                    ],),
                                  ),*/
                                /* Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(" الاجمالي  ${orders[index].totalValue}"),
                                    ],
                                  )*/
                                /*  SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                  Container(
                                    width:MediaQuery.of(context).size.width*.9,
                                    padding: EdgeInsets.only(

                                      top: MediaQuery.of(context).size.height*.01,
                                      // bottom: MediaQuery.of(context).size.height*.01,

                                    ),
                                    child: ListView.builder(
                                        itemCount: orders[index].orderDetails.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemBuilder: (context,i){
                                          return Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*.85,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                       child:FadeInImage.assetNetwork(
                                                          placeholder: "images/prodcut4.png",
                                                          image:orders[index].orderDetails[i].image==null?"":orders[index].orderDetails[i].image,
                                                          height: MediaQuery.of(context).size.height*.06,
                                                          width:  MediaQuery.of(context).size.height*.07,
                                                          fit: BoxFit.cover,
                                                          ),
                                                      ),
                                                        SizedBox(width: 10,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                           Text(orders[index].orderDetails[i].name,style: TextStyle(fontSize: 12,color: Colors.black54)),
                                                         Text("${orders[index].orderDetails[i].price2} ريال ",style: TextStyle(fontSize: 12,color: Color(h.mainColor),),)
                                                       ],
                                                      )

                                                      ],
                                                    ),
                                                    *//*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*//*
                                                   Row(
                                                     children: [
                                                       Icon(Icons.clear,size: 17,color: Colors.black54),
                                                        SizedBox(width: 2),
                                                       Text("${orders[index].orderDetails[i].details.quantity}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                                                       SizedBox(width: 10),
                                                       Icon(Icons.arrow_back_ios_outlined,color: Colors.black54,size: 16,)

                                                     ],
                                                   )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                             Container(
                                              color: Colors.black12,
                                               width: MediaQuery.of(context).size.width*.85,
                                               height: 1,
                                             ),
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                              i==orders[index].orderDetails.length-1?Column(
                                                children: [
                                                 // Divider(color: Colors.black38,thickness: 1,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*.8,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("أجمالي الطلب",style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),),
                                                        *//*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*//*
                                                        Text("${orders[index].totalValue} ريال",style: TextStyle(fontSize: 12,color: Color(h.mainColor),fontWeight: FontWeight.bold),),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ):SizedBox()
                                            ],
                                          );
                                        }),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.005,),*/
                              ],)
                        ),
                      ],
                    ),

                  ),
                  )
                  /*Container(
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.01,right:  MediaQuery.of(context).size.width*.05,left:  MediaQuery.of(context).size.width*.05,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black12.withOpacity(.08),width: 1),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.03),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                            width:MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width*.05,
                              top: MediaQuery.of(context).size.height*.015,
                              bottom: MediaQuery.of(context).size.height*.01,
                              left: MediaQuery.of(context).size.width*.05,
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(" طلب رقم "+orders[index].orderNumber,style: TextStyle(height: .8,fontSize: 16,fontWeight: FontWeight.bold,color: Color(h.mainColor)),),

                                      Text(" الاجمالي  ${orders[index].totalValue}")
                                    ],),
                                ),
                                *//*  SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                  Container(
                                    width:MediaQuery.of(context).size.width*.9,
                                    padding: EdgeInsets.only(

                                      top: MediaQuery.of(context).size.height*.01,
                                      // bottom: MediaQuery.of(context).size.height*.01,

                                    ),
                                    child: ListView.builder(
                                        itemCount: orders[index].orderDetails.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemBuilder: (context,i){
                                          return Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*.85,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                       child:FadeInImage.assetNetwork(
                                                          placeholder: "images/prodcut4.png",
                                                          image:orders[index].orderDetails[i].image==null?"":orders[index].orderDetails[i].image,
                                                          height: MediaQuery.of(context).size.height*.06,
                                                          width:  MediaQuery.of(context).size.height*.07,
                                                          fit: BoxFit.cover,
                                                          ),
                                                      ),
                                                        SizedBox(width: 10,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                           Text(orders[index].orderDetails[i].name,style: TextStyle(fontSize: 12,color: Colors.black54)),
                                                         Text("${orders[index].orderDetails[i].price2} ريال ",style: TextStyle(fontSize: 12,color: Color(h.mainColor),),)
                                                       ],
                                                      )

                                                      ],
                                                    ),
                                                    *//**//*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*//**//*
                                                   Row(
                                                     children: [
                                                       Icon(Icons.clear,size: 17,color: Colors.black54),
                                                        SizedBox(width: 2),
                                                       Text("${orders[index].orderDetails[i].details.quantity}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                                                       SizedBox(width: 10),
                                                       Icon(Icons.arrow_back_ios_outlined,color: Colors.black54,size: 16,)

                                                     ],
                                                   )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                             Container(
                                              color: Colors.black12,
                                               width: MediaQuery.of(context).size.width*.85,
                                               height: 1,
                                             ),
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                              i==orders[index].orderDetails.length-1?Column(
                                                children: [
                                                 // Divider(color: Colors.black38,thickness: 1,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*.8,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("أجمالي الطلب",style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),),
                                                        *//**//*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*//**//*
                                                        Text("${orders[index].totalValue} ريال",style: TextStyle(fontSize: 12,color: Color(h.mainColor),fontWeight: FontWeight.bold),),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ):SizedBox()
                                            ],
                                          );
                                        }),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.005,),*//*
                              ],)
                        ),
                      ],
                    ),

                  ),
                  )*/,
                );
              })):Expanded(
                child: Container(
                    padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.1),child: Center(
                  child: Column(
                    children: [
                      Image.asset("images/orders.png",color: Colors.black26,
                        height: MediaQuery.of(context).size.height*.25,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.035,),
                      Text("لا يوجد طلبات حاليا",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26),),
                      SizedBox(height: MediaQuery.of(context).size.height*.035,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.route(HomePage()));
                        },
                        child: DottedBorder(
                            color: Colors.black26,
                            strokeWidth: 1.5,
                            child: Container(
                              width: MediaQuery.of(context).size.width*.6,
                              height: MediaQuery.of(context).size.height*.05,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                //  border: Border.all(width: 1.0,color: Colors.black26)
                              ),
                              child: Text("تسوق الان",style: TextStyle(fontSize: 12),),
                            )

                        ),
                      )
                    ],
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}