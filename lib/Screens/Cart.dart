import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Model/CartModelLocal.dart';
import 'package:mishwar/app/Services/OrderServices.dart';
import 'package:toast/toast.dart';
import 'GlobalFunction.dart';
import 'package:mishwar/Screens/HomePage.dart';
import '../dbHelper.dart';
import '../main.dart';
import 'login.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/Screens/confirmedorderui/first_step_user_data.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<Cart> {
  home h = new home();
  OrderServices orderServvices = new OrderServices();
  int counter = 1;
  int totalquantity = 0;
  double allPrice = 0.0;
  List dataLocal = [];
  double tax = 0.0;
  DbHelper db = new DbHelper();

  loadData() async {
    dataLocal = await db.allProduct();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: db.allProduct(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return snapshot.data.length == 0
                          ? Container(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * .15),
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.asset("images/icon/cart.png",
                                        color: Colors.black26),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .035,
                                    ),
                                    //nocartdata
                                    Text(
                                      DemoLocalizations.of(context)
                                          .title['nocartdata'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black26),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .035,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                            '/mainPage'
                                             ,(Route<dynamic> route) => false);
                                      },
                                      child: DottedBorder(
                                          color: Colors.black26,
                                          strokeWidth: 1.5,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .06,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              //  border: Border.all(width: 1.0,color: Colors.black26)
                                            ),
                                            child: Text(
                                              DemoLocalizations.of(context)
                                                  .title['shopnow'],
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ))
                          : ListView.builder(
                              itemCount: snapshot.data.length,
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .01,
                              ),
                              itemBuilder: (context, index) {
                                CartMedelLocal c = new CartMedelLocal.fromMap(
                                    snapshot.data[index]);
                                return Container(
                                  padding: EdgeInsets.only(
                                      // left: MediaQuery.of(context).size.width*.02,
                                      // right: MediaQuery.of(context).size.width*.02,
                                      //top: MediaQuery.of(context).size.height*.005,
                                      //bottom: MediaQuery.of(context).size.height*.005
                                      ),
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          .008,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              .008,
                                      left: MediaQuery.of(context).size.width *
                                          .05,
                                      right: MediaQuery.of(context).size.width *
                                          .05),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          width: 1.0,
                                          color:
                                              Colors.black12.withOpacity(.05)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(3,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                //  top: MediaQuery.of(context).size.height*.003
                                                ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  // margin: EdgeInsets.zero,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.white),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .12,
                                                  margin: EdgeInsets.only(
                                                      // left:  MediaQuery.of(context).size.width*.028,
                                                      // right:   MediaQuery.of(context).size.width*.028,
                                                      //top: MediaQuery.of(context).size.height*.015,
                                                      //  bottom: MediaQuery.of(context).size.height*.015,
                                                      ),
                                                  child: ClipRRect(
                                                    borderRadius: DemoLocalizations
                                                                    .of(context)
                                                                .locale ==
                                                            Locale("ar")
                                                        ? BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))
                                                        : BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10)),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          "images/prodcut4.png",
                                                      image: c.img == null
                                                          ? ""
                                                          : c.img,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .9,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .15,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .12,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .005,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .61,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              c.name,
                                                              style: TextStyle(
                                                                  height: 1.0,
                                                                  fontSize: 14,
                                                                  color: Color(h
                                                                      .mainColor)),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .zero,
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: InkWell(
                                                                child:
                                                                    Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                2),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .delete,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              Color(h.mainColor),
                                                                        )),
                                                                onTap: () {
                                                                  DeleteFromCart(
                                                                      context,
                                                                      c.id,
                                                                      c
                                                                          .quantity,
                                                                      c.price *
                                                                          c.quantity);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .00,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .5,
                                                        child: c.description ==
                                                                null
                                                            ? SizedBox()
                                                            : Text(
                                                                c.description,
                                                                style: TextStyle(
                                                                    height: 1.0,
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black38),
                                                                maxLines: 2,
                                                              ),
                                                      ),
                                                      SizedBox(
                                                        height: 1,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .61,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              c.price2.toString() +
                                                                  ' ' +
                                                                  DemoLocalizations.of(
                                                                              context)
                                                                          .title[
                                                                      'currency'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 11),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    CartMedelLocal
                                                                        cartLDBModel =
                                                                        CartMedelLocal({
                                                                      'id':
                                                                          c.id,
                                                                      'name': c
                                                                          .name,
                                                                      'img':
                                                                          c.img,
                                                                      'price': c
                                                                          .price,
                                                                      "price2":
                                                                          c.price2,
                                                                      'description':
                                                                          c.description,
                                                                      'quantity':
                                                                          c.quantity +
                                                                              1,
                                                                    });
                                                                    print(c.id);
                                                                    print(
                                                                        c.name);
                                                                    print(c
                                                                        .price);
                                                                    print(c
                                                                        .price2);
                                                                    print(c
                                                                        .description);
                                                                    print(c
                                                                        .quantity);
                                                                    print(
                                                                        "000000000000000000000000000000000000");

                                                                    setState(
                                                                        () {
                                                                      db.updateCourse(
                                                                          cartLDBModel);
                                                                      // updateTotal(1, c.price);
                                                                      getTotal();
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                    // color: Colors.red,
                                                                    child:
                                                                        Container(
                                                                      width: 18,
                                                                      height:
                                                                          18,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              1000)),
                                                                          border: Border.all(
                                                                              color: Color(h.blueColor),
                                                                              width: 1.0),
                                                                          color: Colors.white),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        size:
                                                                            16,
                                                                        color: Color(
                                                                            h.blueColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // SizedBox(width: 3,),
                                                                Container(
                                                                  width: 18,
                                                                  height: 18,
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child: Text(
                                                                    c.quantity
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                // SizedBox(width: 3,),
                                                                InkWell(
                                                                  onTap: () {
                                                                    CartMedelLocal
                                                                        cartLDBModel =
                                                                        CartMedelLocal({
                                                                      'id':
                                                                          c.id,
                                                                      'name': c
                                                                          .name,
                                                                      'img':
                                                                          c.img,
                                                                      'price': c
                                                                          .price,
                                                                      "price2":
                                                                          c.price2,
                                                                      'description':
                                                                          c.description,
                                                                      'quantity':
                                                                          c.quantity -
                                                                              1,
                                                                    });
                                                                    if (c.quantity >
                                                                        1) {
                                                                      setState(
                                                                          () {
                                                                        db.updateCourse(
                                                                            cartLDBModel);
                                                                        // updateTotal(-1, -c.price);
                                                                        getTotal();
                                                                      });
                                                                    } else {
                                                                      DeleteFromCart(
                                                                          context,
                                                                          c.id,
                                                                          c.quantity,
                                                                          c.totalPrice);
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.only(
                                                                        left: 4,
                                                                        right:
                                                                            10,
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                    // color: Colors.red,

                                                                    child:
                                                                        Container(
                                                                      width: 18,
                                                                      height:
                                                                          18,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              500)),
                                                                          border: Border.all(
                                                                              color: Color(h.mainColor),
                                                                              width: 1.0),
                                                                          color: Colors.white),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        size:
                                                                            16,
                                                                        color: Color(
                                                                            h.mainColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .005,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                    }
                  }),
            ),
            totalquantity > 0
                ? Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .05,
                      right: MediaQuery.of(context).size.width * .05,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(color: Colors.black12, width: 1)),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    color: Color(0xffdedede).withOpacity(.5)),
                                alignment: Alignment.center,
                                //paymentDetails
                                child: Text(
                                  DemoLocalizations.of(context)
                                      .title['paymentDetails'],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3 -
                                            2,
                                    height: MediaQuery.of(context).size.height *
                                        .04,
                                    decoration: BoxDecoration(),
                                    alignment: Alignment.center,
                                    child: Text(
                                      DemoLocalizations.of(context)
                                          .title['qunt'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    height: MediaQuery.of(context).size.height *
                                        .04,
                                    decoration: BoxDecoration(),
                                    alignment: Alignment.center,
                                    child: Text(
                                      DemoLocalizations.of(context)
                                              .title['Tax'] +
                                          '% 15',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    height: MediaQuery.of(context).size.height *
                                        .04,
                                    decoration: BoxDecoration(),
                                    alignment: Alignment.center,
                                    child: Text(
                                      DemoLocalizations.of(context)
                                          .title['Totaldemand'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 1,
                                    width:
                                        MediaQuery.of(context).size.width * .27,
                                    color: Colors.black12,
                                  ),
                                  Container(
                                    height: 1,
                                    width:
                                        MediaQuery.of(context).size.width * .27,
                                    color: Colors.black12,
                                  ),
                                  Container(
                                    height: 1,
                                    width:
                                        MediaQuery.of(context).size.width * .27,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3 -
                                            2,
                                    height: MediaQuery.of(context).size.height *
                                        .04,
                                    decoration: BoxDecoration(),
                                    alignment: Alignment.center,
                                    child: Text(
                                      totalquantity.toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    height: MediaQuery.of(context).size.height *
                                        .04,
                                    decoration: BoxDecoration(),
                                    alignment: Alignment.center,
                                    child: Text(
                                      tax.toStringAsFixed(2) +
                                          ' ' +
                                          DemoLocalizations.of(context)
                                              .title['currency'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    height: MediaQuery.of(context).size.height *
                                        .04,
                                    decoration: BoxDecoration(),
                                    alignment: Alignment.center,
                                    child: Text(
                                      ((allPrice - tax).toStringAsFixed(2))
                                              .toString() +
                                          ' ' +
                                          DemoLocalizations.of(context)
                                              .title['currency'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        /*        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("تفاصيل الفاتورة ",style: TextStyle(fontSize: 12,color:Colors.black),)                      ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.005,),
                      Divider(color: Colors.black26,height: 1,),
                      SizedBox(height: MediaQuery.of(context).size.height*.005,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("مجموع الطلبات ",style: TextStyle(fontSize: 12,color:Colors.black),),
                          Text((allPrice-tax).toString(),style: TextStyle(fontSize: 12,color:Colors.black),)
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.005,),
                      Divider(color: Colors.black26,height: 1,),
                      SizedBox(height: MediaQuery.of(context).size.height*.005,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("اجمالي الكمية ",style: TextStyle(fontSize: 12,color:Colors.black),),
                          Text(totalquantity.toString(),style: TextStyle(fontSize: 12,color:Colors.black),)
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.005,),
                      Divider(color: Colors.black26,height: 1,),
                      SizedBox(height: MediaQuery.of(context).size.height*.005,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("الضريبة 15% ",style: TextStyle(fontSize: 12,color:Colors.black),),
                          Text(tax.toString(),style: TextStyle(fontSize: 12,color:Colors.black),)
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.005,),
                      Divider(color: Colors.black26,height: 1,),
                      SizedBox(height: MediaQuery.of(context).size.height*.005,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("الاجمالي ",style: TextStyle(fontSize: 12,color: Color(h.mainColor),),),
                          Text((allPrice).toString(),style: TextStyle(fontSize: 12,color: Color(h.mainColor)),)
                        ],
                      ),*/
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                //right:  MediaQuery.of(context).size.width*.2,
                                //left:  MediaQuery.of(context).size.width*.2
                                ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(h.blueColor),
                            ),
                            height: MediaQuery.of(context).size.height * .05,
                            //  width: MediaQuery.of(context).size.width*.8,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .07,
                              right: MediaQuery.of(context).size.width * .07,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    DemoLocalizations.of(context)
                                            .title['Total'] +
                                        " " +
                                        (allPrice)
                                            .toStringAsFixed(2)
                                            .toString() +
                                        " " +
                                        DemoLocalizations.of(context)
                                            .title['currency'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                                Text(
                                    DemoLocalizations.of(context)
                                        .title['Continuetopurchase'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12))
                              ],
                            ),
                          ),
                          onTap: () async {
                            if (allPrice > 30.0) {
                              if (home.username == null) {
                                Navigator.push(context,
                                    GlobalFunction.routeBottom(login("cart")));
                              } else {
                                Navigator.push(
                                    context,
                                    GlobalFunction.routeBottom(
                                        FirstStepUserData()));
                              }
                            } else {
                              Toast.show(
                                  DemoLocalizations.of(context)
                                      .title['ordermorethan'], context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ) ;
  }

  getTotal() async {
    //totalquantity=0;
    //allPrice=0.0;
    print("555555555555555555555555");
    List product = await db.allProduct();
    // home.c=product.length;
    allPrice = 0.0;
    tax = 0.0;
    totalquantity = 0;
    for (int i = 0; i < product.length; i++) {
      CartMedelLocal c = new CartMedelLocal.fromMap(product[i]);
      totalquantity += int.parse(c.quantity.toString());
      allPrice += double.parse((c.price2 * c.quantity).toString());
      tax += (c.price * c.quantity * 15) / 100;
      print(tax.toString());
      setState(() {});
    }
  }

  updateTotal(int q, double p) {
    totalquantity += q;
    allPrice += p;
    setState(() {});
  }

  DeleteFromCart(BuildContext context, id, int quantity, double totalPrice) {
    print(quantity.toString());
    print(totalPrice);
    print("000000000000000");
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 150.0,
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black12,width: 2.0),
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
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "images/icon/about.png",
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              "تـأكيد الحذف من سلة المشتريات",
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(h.blueColor)),
                                  height:
                                      MediaQuery.of(context).size.height * .045,
                                  width:
                                      MediaQuery.of(context).size.width * .33,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "الغاء",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(h.mainColor)),
                                  height:
                                      MediaQuery.of(context).size.height * .045,
                                  width:
                                      MediaQuery.of(context).size.width * .33,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "تـأكيد",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                onTap: () async {
                                  loadData();
                                  setState(() {
                                    db.delete(id);
                                  });
                                  updateTotal(-quantity, -totalPrice);
                                  getTotal();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  AddToCard(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 130.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    border: Border.all(color: Colors.black12, width: 2.0),
                    color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center
                      // ,crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            color: Colors.white),
                                        // padding:EdgeInsets.all(2),
                                        child: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 13),
                                        child: Icon(
                                          Icons.check_circle_outline,
                                          size: 50,
                                          color: Color(h.mainColor),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(1000)),
                                              color: Color(h.mainColor)),
                                          padding: EdgeInsets.all(2.5),
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "تم اضافة الطلب بنجاح",
                                  style: TextStyle(
                                      color: Color(h.blueColor),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}

class Items {
  String ItemID;
  String Quantity;
  String SalePrice;
  String SubTotal;
  String TotalValue;
  String Notes;

  Items(
      {this.ItemID,
      this.Quantity,
      this.SalePrice,
      this.SubTotal,
      this.TotalValue,
      this.Notes});

  Map<String, dynamic> toJson() => {
        "ItemID": ItemID,
        "Quantity": Quantity,
        "SalePrice": SalePrice,
        "SubTotal": SubTotal,
        "TotalValue": TotalValue,
        "Notes": Notes,
      };
}
