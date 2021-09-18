import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mishwar/app/AppConfig.dart';
import 'package:mishwar/app/Services/ProductServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/CartModelLocal.dart';
import '../Model/FavouriteLocalModel.dart';
import '../dbHelper.dart';
import '../Model/ProductModel.dart';
import '../Model/SubProductModel.dart';
import '../main.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<MainPage> {
  DbHelper dbHelper = new DbHelper();
  TextEditingController message = new TextEditingController();
  List<SubProductDetail> subProduct = [];
  var i = 0;
  home h = new home();

  @override
  void initState() {
    productServices.getCategory();

    productServices.getProduct('1', '1');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => WillPopScope(
              onWillPop: () async {
                confirmCloseApp(context);
                return true;
              },
              child: Expanded(
                // color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .28,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .2,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "images/1599519080-mishwar menus.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: MediaQuery.of(context).size.width * .75,
                          top: MediaQuery.of(context).size.height * .175,
                          child: GestureDetector(
                            onTap: () {
                              _makingPhoneCall();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: Color(0xff55b866)),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: MediaQuery.of(context).size.width * .35,
                          top: MediaQuery.of(context).size.height * .125,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .14,
                            width: MediaQuery.of(context).size.width * .3,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // border: Border.all(color: Colors.white,width: 1),
                              color: Color.fromRGBO(255, 255, 255, 0.67),
                              //color:Color(0xffffffab).withOpacity(.02),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.05),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .15 -
                                        10,
                                width:
                                    MediaQuery.of(context).size.width * .3 - 10,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    // border: Border.all(color: Colors.black12.withOpacity(.05),width: 5),
                                    color: Colors.white),
                                child: Image.asset("images/logo.png"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    /*Container(
                height: MediaQuery.of(context).size.height*.26,
               //color: Colors.red,
                child:  new Swiper(
                          itemBuilder: (BuildContext context,int index){
                            return Column(children: [
                              Image.asset("images/slider .png",fit: BoxFit.fill,height: MediaQuery.of(context).size.height*.23 ,
                              width: MediaQuery.of(context).size.width,
                              ) ,

                            ],);
                          },
                          autoplay: true,
                          itemCount: 3,
                          pagination: new SwiperPagination(
                         margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*.0),
                            builder: new DotSwiperPaginationBuilder(
                              color: Colors.grey, activeColor: Color(h.mainColor),
                            ),

                          ),
                          control: new SwiperControl(
                            color: Colors.white,
                            size: 0
                          ),
                        ),
           ),*/
                    ,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .00,
                    ),
                    //Divider(color:Colors.black12,thickness: 1.5,height: MediaQuery.of(context).size.height*.01,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .0,
                    ),
                    Container(
                        height: 32,
                        child: !appConfig.dApp.loadCategory
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : appConfig.dApp.mainCategoryList.isNotEmpty
                                ? ListView.builder(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .025),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        appConfig.dApp.mainCategoryList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          appConfig.dApp.setSelectedCategory(
                                              appConfig.dApp
                                                  .mainCategoryList[index]);
                                          productServices.getProduct(
                                              appConfig.dApp
                                                  .mainCategoryList[index].id
                                                  .toString(),
                                              '1');
                                          print(
                                              '${appConfig.dApp.selectedCategory == appConfig.dApp.mainCategoryList[index].id}');
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    height: 30,
                                                    padding: EdgeInsets.only(
                                                        bottom: 1,
                                                        left: 10,
                                                        right: 10),
                                                    margin: EdgeInsets.only(
                                                        left: 3, right: 3),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                        color: appConfig.dApp.selectedCategory ==
                                                                appConfig
                                                                    .dApp
                                                                    .mainCategoryList[
                                                                        index]
                                                                    .id
                                                            ? Color(0xff55b866)
                                                            : Colors.grey
                                                        /* border: Border(
                                 bottom: BorderSide(
                                   color:SelectedCategory==categories[index].id?Color(h.mainColor):Colors.white,
                                   width: 1.5,
                                 ))*/
                                                        ),
                                                    alignment: Alignment.center,
                                                    child: Text(appConfig.dApp.mainCategoryList[index].name,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                        textAlign: TextAlign.center)),
                                              ],
                                            )),
                                      );
                                    })
                                : Center(
                                    child: Text(
                                      DemoLocalizations.of(context)
                                          .title['nologdata'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .005,
                    ),
                    !appConfig.dApp.loadProducts
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : appConfig.dApp.mainProductsList.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: Text(
                                    DemoLocalizations.of(context)
                                        .title['nologdata'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .01,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                .03),
                                    itemCount:
                                        appConfig.dApp.mainProductsList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (appConfig
                                                  .dApp
                                                  .mainProductsList[index]
                                                  .subItems
                                                  .length ==
                                              0)
                                            ProductDetails(
                                                1,
                                                appConfig.dApp
                                                    .mainProductsList[index]);
                                          else {
                                            ProductDetails2(
                                                1,
                                                appConfig.dApp
                                                    .mainProductsList[index],
                                                appConfig
                                                    .dApp
                                                    .mainProductsList[index]
                                                    .subItems);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 3,
                                                blurRadius: 3,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .125,
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .01,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .05,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .05),
                                          padding: DemoLocalizations.of(context)
                                                      .locale ==
                                                  Locale("ar")
                                              ? EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .02,
                                                )
                                              : EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .02,
                                                ),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(

                                              children: [
                                                ClipRRect(
                                                    borderRadius: DemoLocalizations.of(context)
                                                                .locale ==
                                                            Locale("ar")
                                                        ? BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10))
                                                        : BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10)),
                                                    child: appConfig
                                                                .dApp
                                                                .mainProductsList[index]
                                                                .image ==
                                                            null
                                                        ? Image.asset(
                                                            "images/no-img.jpg",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .20,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .120,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : FadeInImage.assetNetwork(
                                                            placeholder:
                                                                "images/Spinner.gif",
                                                            image: appConfig
                                                                        .dApp
                                                                        .mainProductsList[
                                                                            index]
                                                                        .image ==
                                                                    null
                                                                ? ""
                                                                : appConfig
                                                                    .dApp
                                                                    .mainProductsList[
                                                                        index]
                                                                    .image,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .27,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .120,
                                                            fit: BoxFit.cover,
                                                          )),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .02,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .59,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .42,
                                                              child: Text(
                                                                appConfig
                                                                    .dApp
                                                                    .mainProductsList[
                                                                        index]
                                                                    .name,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: Color(h
                                                                        .mainColor),
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                          Row(
                                                            children: [
                                                              GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    FavoriteModelLocal
                                                                        favoriteModel =
                                                                        FavoriteModelLocal({
                                                                      'id': int.parse(appConfig
                                                                          .dApp
                                                                          .mainProductsList[
                                                                              index]
                                                                          .id),
                                                                      'title': appConfig
                                                                          .dApp
                                                                          .mainProductsList[
                                                                              index]
                                                                          .name,
                                                                      "description": appConfig
                                                                          .dApp
                                                                          .mainProductsList[
                                                                              index]
                                                                          .description,
                                                                      "img": appConfig
                                                                          .dApp
                                                                          .mainProductsList[
                                                                              index]
                                                                          .image,
                                                                      'price': double.parse(appConfig
                                                                          .dApp
                                                                          .mainProductsList[
                                                                              index]
                                                                          .price2),
                                                                    });
                                                                    int x = await triggerFavourite(
                                                                        int.parse(appConfig
                                                                            .dApp
                                                                            .mainProductsList[
                                                                                index]
                                                                            .id),
                                                                        favoriteModel);
                                                                    // print('${x},,,,,,favorite');
                                                                    if (mounted)
                                                                      setState(
                                                                          () {});
                                                                    if (x == 1) {
                                                                      Toast.show(
                                                                          DemoLocalizations.of(context).title[
                                                                              'addtofavorite'],
                                                                          context,
                                                                          duration:
                                                                              Toast
                                                                                  .LENGTH_SHORT,
                                                                          gravity:
                                                                              Toast.BOTTOM);
                                                                    } else {
                                                                      Toast.show(
                                                                          DemoLocalizations.of(context).title[
                                                                              'removetofavorite'],
                                                                          context,
                                                                          duration:
                                                                              Toast
                                                                                  .LENGTH_SHORT,
                                                                          gravity:
                                                                              Toast.BOTTOM);
                                                                    }
                                                                  },
                                                                  child:
                                                                      FutureBuilder<
                                                                          int>(
                                                                    future: getFavouriteStatus(
                                                                        int.parse(appConfig
                                                                            .dApp
                                                                            .mainProductsList[
                                                                                index]
                                                                            .id)),
                                                                    builder: (context,
                                                                        snapData) {
                                                                      int x =
                                                                          snapData
                                                                              .data;
                                                                      return Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                2),
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                1),
                                                                        child:
                                                                            Icon(
                                                                          x == 1
                                                                              ? Icons.star
                                                                              : Icons.star_border,
                                                                          color: Color(
                                                                              h.blueColor),
                                                                          size:
                                                                              26,
                                                                        ),
                                                                      );
                                                                    },
                                                                  )),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                child: Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              100)),
                                                                      border: Border.all(
                                                                          color: Color(h
                                                                              .mainColor),
                                                                          width:
                                                                              1),
                                                                      color: Colors
                                                                          .white),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 18,
                                                                    color: Color(h
                                                                        .mainColor),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        appConfig
                                                                    .dApp
                                                                    .mainProductsList[
                                                                        index]
                                                                    .description ==
                                                                null
                                                            ? "Product Description"
                                                            : appConfig
                                                                .dApp
                                                                .mainProductsList[
                                                                    index]
                                                                .description,
                                                        style: TextStyle(
                                                            height: 1.0,
                                                            fontSize: 10,
                                                            color:
                                                                Colors.black38),
                                                        maxLines: 2,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            //currency
                                                            "${appConfig.dApp.mainProductsList[index].price2}" +
                                                                DemoLocalizations.of(
                                                                            context)
                                                                        .title[
                                                                    'currency'],
                                                            style: TextStyle(
                                                                color: Color(
                                                                    h.mainColor),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                        ),
                                      );
                                    }),
                              ),
                  ],
                ),
              ),
            ));
  }

  void ProductDetails(int counter, ProductDetail product) {
    int counter2 = counter;
    showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) => Scaffold(
                backgroundColor: Colors.transparent,
                body:  Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(
                        // top: MediaQuery.of(context).size.height*.4
                        ),
                    color: Colors.transparent,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .72,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .23),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "images/no-img.jpg",
                                        image: product.image == null
                                            ? ""
                                            : product.image,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .32,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        right: 15,
                                        top: 15,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1000)),
                                                color: Colors.white),
                                            child: Icon(
                                              Icons.clear,
                                              size: 20,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          .05,
                                      right: MediaQuery.of(context).size.width *
                                          .05),
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .025,
                                            ),
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .015,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .33,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            100)),
                                                            border: Border.all(
                                                                color: Color(h
                                                                    .mainColor),
                                                                width: 1.0),
                                                            color:
                                                                Colors.white),
                                                        alignment:
                                                            Alignment.center,
                                                        child: InkWell(
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 22,
                                                            color: Color(
                                                                h.mainColor),
                                                          ),
                                                          onTap: () {
                                                            if (counter2 > 1) {
                                                              setState(() {
                                                                counter2 =
                                                                    counter2 -
                                                                        1;
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 25,
                                                        height: 32,
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 7),
                                                        child: Text(
                                                          "$counter2",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            100)),
                                                            border: Border.all(
                                                                color: Color(h
                                                                    .blueColor),
                                                                width: 1.0),
                                                            color:
                                                                Colors.white),
                                                        alignment:
                                                            Alignment.center,
                                                        child: InkWell(
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 22,
                                                            color: Color(
                                                                h.blueColor),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              counter2 =
                                                                  counter2 + 1;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "${product.price2 == null ? "0" : product.price2}" +
                                                      DemoLocalizations.of(
                                                              context)
                                                          .title['currency'],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .03,
                                            ),
                                            Text(
                                              DemoLocalizations.of(context)
                                                  .title['makenote'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(h.blueColor)),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .015,
                                            ),
            Container(
              width: MediaQuery.of(context).size.width*.9,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.all(Radius.circular(5)),
                color: Colors.white,
              ),
              child: TextFormField(
                minLines: 1,
                maxLines: 2,
                keyboardType: TextInputType.text,
                //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black12)
                  ),
                  focusedBorder:  new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black12)
                  ),
                  focusedErrorBorder:new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  errorBorder:new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  hintText:DemoLocalizations.of(context)
                      .title['Wouldyouliketotellusanythingelse?']
                  ,
                  hintStyle: TextStyle(color: Colors.black54,fontSize: 10),
                  prefixIcon: Icon(Icons.message,color: Colors.black26,),
                  prefixIconConstraints:BoxConstraints(
                      maxHeight: 25,
                      minHeight: 20,
                      maxWidth: 50,
                      minWidth: 40
                  ) ,
                ),
                controller: message,
              ),
            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .03,
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                //right:  MediaQuery.of(context).size.width*.2,
                                                //left:  MediaQuery.of(context).size.width*.2
                                                ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color(h.blueColor),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .06,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .9,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .07,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .07,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${double.parse(product.price2) * counter2} " +
                                                      DemoLocalizations.of(
                                                              context)
                                                          .title['currency'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  DemoLocalizations.of(context)
                                                      .title['addtoCart'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            )),
                                        onTap: () async {
                                          // Navigator.pushNamed(context, '/Cart');
                                          CartMedelLocal p1 =
                                              new CartMedelLocal({
                                            "id": int.parse(product.id),
                                            "name": product.name,
                                            "img": product.image,
                                            "description": product.description,
                                            "price":
                                                double.parse(product.price),
                                            "price2":
                                                double.parse(product.price2),
                                            "totalPrice": 0.0,
                                            "quantity": counter2
                                          });
                                          try {
                                            Navigator.pop(context);
                                            addProductDialog(context, counter2);

                                            await dbHelper.addToCart(p1);

                                            /* Toast.show(
                                          "تم اضافة المنتج", context,
                                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);*/

                                          } catch (e) {
                                            Navigator.pop(context);
                                            addProductDialog(context, counter2);

                                            dbHelper.updateCourse(p1);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ),

              ),
            ));
  }

  Widget ProductDetails2(
      int counter, ProductDetail product, List<SubProductDetail1> data) {
    print(data.length);
    print("dddddddddddddddddddddd");
    int counter2 = counter;
    SubProductDetail1 selectedProduct = data[0];
    showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) => Scaffold(
                body:  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      /*   borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20)
                                          ),*/
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "images/no-img.jpg",
                                        image: product.image == null
                                            ? ""
                                            : product.image,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .32,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        right: 15,
                                        top: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1000)),
                                                color: Colors.white),
                                            child: Icon(
                                              Icons.clear,
                                              size: 20,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          .05,
                                      right: MediaQuery.of(context).size.width *
                                          .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .025,
                                      ),
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .005,
                                      ),
                                      Text(
                                        product.description,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .015,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .33,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  100)),
                                                      border: Border.all(
                                                          color: Color(
                                                              h.mainColor),
                                                          width: 1.0),
                                                      color: Colors.white),
                                                  alignment: Alignment.center,
                                                  child: InkWell(
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 22,
                                                      color: Color(h.mainColor),
                                                    ),
                                                    onTap: () {
                                                      if (counter2 > 1) {
                                                        setState(() {
                                                          counter2 =
                                                              counter2 - 1;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  width: 25,
                                                  height: 32,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                      bottom: 7),
                                                  child: Text(
                                                    "$counter2",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  100)),
                                                      border: Border.all(
                                                          color: Color(
                                                              h.blueColor),
                                                          width: 1.0),
                                                      color: Colors.white),
                                                  alignment: Alignment.center,
                                                  child: InkWell(
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 22,
                                                      color: Color(h.blueColor),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        counter2 = counter2 + 1;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "${product.price2 == null ? "0" : product.price2} "+DemoLocalizations.of(context)
                                                .title['currency']
                                            ,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .025,
                                      ),
                                      Row(
                                        children: [
                                          //
                                          Text(DemoLocalizations.of(context)
                                              .title['Choosetherighttype']
                                              ,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(h.blueColor))),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .015,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // padding:EdgeInsets.only(top:5,bottom:5),
                                        padding: EdgeInsets.only(right: 10,left: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.black12, width: 1),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(.1),
                                              spreadRadius: 3,
                                              blurRadius: 3,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        margin: EdgeInsets.only(
                                            //left:MediaQuery.of(context).size.width*.05,
                                            //right: MediaQuery.of(context).size.width*.05,
                                            ),
                                        child: ListView.builder(
                                            itemCount: data.length,
                                            primary: false,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedProduct =
                                                              data[index];
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(data[index].name,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black)),
                                                          Radio(
                                                            value: data[index],
                                                            groupValue:
                                                                selectedProduct,
                                                            onChanged: (val) {
                                                              print(val);
                                                              print(
                                                                  "sssssssssssssssss");
                                                              setState(() {
                                                                selectedProduct =
                                                                    val;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    index == data.length - 1
                                                        ? SizedBox()
                                                        : Container(
                                                            height: 1,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            color:
                                                                Colors.black12,
                                                          )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .025,
                                      ),
                                      Text(
                                        DemoLocalizations.of(context)
                                            .title['makenote']
                                        ,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(h.blueColor)),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .015,
                                      ),
                        Container(
                          width: MediaQuery.of(context).size.width*.9,
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.text,
                            //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black12)
                              ),
                              focusedBorder:  new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black12)
                              ),
                              focusedErrorBorder:new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)
                              ),
                              errorBorder:new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)
                              ),
                              hintText:DemoLocalizations.of(context)
                                  .title['Wouldyouliketotellusanythingelse?']
                              ,
                              hintStyle: TextStyle(color: Colors.black54,fontSize: 10),
                              prefixIcon: Icon(Icons.message,color: Colors.black26,),
                              prefixIconConstraints:BoxConstraints(
                                  maxHeight: 25,
                                  minHeight: 20,
                                  maxWidth: 50,
                                  minWidth: 40
                              ) ,
                            ),
                            controller: message,
                          ),
                        ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                height:
                                    MediaQuery.of(context).size.height * .06,
                                width: MediaQuery.of(context).size.width * .9,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * .07,
                                  right:
                                      MediaQuery.of(context).size.width * .07,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${double.parse(selectedProduct.price2) * counter2} "+DemoLocalizations.of(context)
                                          .title['currency']
                                      ,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      DemoLocalizations.of(context)
                                          .title['addtoCart']
                                      ,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                )),
                            onTap: () async {
                              // Navigator.pushNamed(context, '/Cart');
                              CartMedelLocal p1 = new CartMedelLocal({
                                "id": int.parse(selectedProduct.id),
                                "name": selectedProduct.name,
                                "img": selectedProduct.image,
                                "description": selectedProduct.description,
                                "price": double.parse(selectedProduct.price),
                                "price2": double.parse(selectedProduct.price2),
                                "totalPrice": 0.0,
                                "quantity": counter2
                              });
                              try {
                                Navigator.pop(context);
                                addProductDialog(context, counter2);

                                await dbHelper.addToCart(p1);

                                /* Toast.show(
                                        "تم اضافة المنتج", context,
                                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);*/

                              } catch (e) {
                                Navigator.pop(context);
                                addProductDialog(context, counter2);

                                dbHelper.updateCourse(p1);
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ),

              ),
            ));
  }

  addProductDialog(BuildContext context, int count) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 150.0,
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
                                  DemoLocalizations.of(context)
                                      .title['adddone']
                                  ,
                                  style: TextStyle(
                                      color: Color(h.blueColor),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  DemoLocalizations.of(context)
                                      .title['qunt']+"  $count",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                // Text("${title}",textAlign: TextAlign.center,)
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  Future<int> triggerFavourite(
      int productId, FavoriteModelLocal favoriteModel) async {
    int status = await getFavouriteStatus(productId);
    if (status == 0) {
      dbHelper.addToFavorite(favoriteModel);
      return 1;
    } else {
      dbHelper.deleteFavorite(productId);
      return 0;
    }
  }

  Future<int> getFavouriteStatus(int productId) async {
    bool found = await dbHelper.isProductFoundInFavouriteTable(productId);
    if (found == true) {
      return 1;
    } else {
      return 0;
    }
  }

  _makingPhoneCall() async {
    const url = 'tel:920007749';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  confirmCloseApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    border: Border.all(color: Colors.black12, width: 2.0),
                    color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/icon/about.png",
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                   DemoLocalizations.of(context)
                                      .title['Doyouwanttoclosetheapplication?'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                // Text("${title}",textAlign: TextAlign.center,)
                              ],
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
                                      border: Border.all(
                                          color: Colors.black38, width: 1.0),
                                      color: Colors.white),
                                  height:
                                      MediaQuery.of(context).size.height * .045,
                                  width:
                                      MediaQuery.of(context).size.width * .32,
                                  alignment: Alignment.center,
                                  child: Text(
                                    DemoLocalizations.of(context)
                                        .title['cancell'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
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
                                      MediaQuery.of(context).size.width * .32,
                                  alignment: Alignment.center,
                                  child: Text(
                                    DemoLocalizations.of(context)
                                        .title['confirm']
                                    ,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                                onTap: () async {
                                  SystemNavigator.pop();
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
}
