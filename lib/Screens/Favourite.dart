import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Model/FavouriteLocalModel.dart';
 import 'package:mishwar/Model/SubProductModel.dart';
import 'package:mishwar/app/Services/ProductServices.dart';
 import 'GlobalFunction.dart';
import 'package:mishwar/Screens/HomePage.dart';
import 'package:mishwar/dbHelper.dart';
import '../dbHelper.dart';
import 'package:toast/toast.dart';
import '../Model/CartModelLocal.dart';
import '../main.dart';
import 'CustomAppBar.dart';

import 'package:mishwar/lang/app_Localization.dart';


class Favourite extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Favourite>{
  List<SubProductDetail>subProduct=[];
  ProductServices productServices=new ProductServices();
  TextEditingController message=new TextEditingController();
  home h=new home();
  DbHelper dbHelper=new DbHelper();
  DbHelper db=new DbHelper();
  int index=0;
  List  dataLocal=[];
  loadData()async{
    dataLocal=await db.allFavorite();
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
              children: [
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * .02,),
                dataLocal.length == 0 ?
                Expanded(
                  child: Container(
                      padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.15),child: Center(
                    child: Column(
                      children: [
                        Image.asset("images/icon/star.png",color: Colors.black26),
                        SizedBox(height: MediaQuery.of(context).size.height*.035,),
                        Text(DemoLocalizations.of(context).title['nofavorite'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black26),),
                        SizedBox(height: MediaQuery.of(context).size.height*.035,),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                                '/mainPage'
                                //userType=="2"?"/DeleverMain":"/mainPage",
                                ,(Route<dynamic> route) => false);
                           },
                          child: DottedBorder(
                              color: Colors.black26,
                              strokeWidth: 1.5,
                              child: Container(
                                width: MediaQuery.of(context).size.width*.6,
                                height: MediaQuery.of(context).size.height*.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  //  border: Border.all(width: 1.0,color: Colors.black26)
                                ),
                                child: Text(DemoLocalizations.of(context).title['shopnow'],style: TextStyle(fontSize: 12),),
                              )

                          ),
                        )
                      ],
                    ),
                  ))
                ) :
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(
                        //left: MediaQuery.of(context).size.width*.035,
                        //right: MediaQuery.of(context).size.width*.035,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        //color: Colors.grey.withOpacity(0.25),
                      ),
                      child: FutureBuilder(
                          future: db.allFavorite(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            else {
                              return ListView.builder(
                                shrinkWrap: false,
                                padding: EdgeInsets.zero,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  FavoriteModelLocal c = new FavoriteModelLocal
                                      .fromMap(snapshot.data[index]);
                                  //totalquantity+=int.parse(c.quantity.toString());
                                  //allPrice+=double.parse(c.totalPrice.toString());
                                  return     GestureDetector(
                                    onTap: () async {
                                      subProduct=await productServices.GetSubProduct(c.id);
                                      if(subProduct.length==1)
                                        ProductDetails(1,c,subProduct);
                                      else
                                      {
                                        print("sssssssssssssss");
                                        ProductDetails2(1,c,subProduct);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: Offset(
                                                0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * .1,
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * .01,
                                          left: MediaQuery
                                              .of(context)
                                              .size
                                              .width * .05,
                                          right: MediaQuery
                                              .of(context)
                                              .size
                                              .width * .05
                                      ),
                                      padding:DemoLocalizations.of(context)
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
                                            child: FadeInImage.assetNetwork(
                                              placeholder: "images/prodcut4.png",
                                              image:c.img==null?"":c.img,
                                              width: MediaQuery.of(context).size.width*.25,
                                              height: MediaQuery.of(context).size.height*.1,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * .02,),
                                          Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * .61,

                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: 0
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*.005
                                                        ),
                                                        child: Text(c.title, style: TextStyle(
                                                            height: 1.5,
                                                            color: Color(h.mainColor),
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .bold),),
                                                      ),

                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: (){
                                                              DeleteFromFavorite(context,c.id);
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: 5,right: 5,top: MediaQuery.of(context).size.height*.005,bottom: 5
                                                              ),
                                                              child: Container(
                                                                width: 20,
                                                                height: 22,
                                                                child: Icon(Icons.star,size: 26,
                                                                  color: Color(h.blueColor),),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 3,),
                                                       Container(
                                                              padding: EdgeInsets.only(
                                                                  left: 5,right: 5,top:MediaQuery.of(context).size.height*.005,bottom: 0
                                                              ),
                                                              child: Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                                                    border: Border.all(   color: Color(h.mainColor),width: 1),
                                                                    color: Colors.white
                                                                ),
                                                                child: Icon(Icons.add,size: 18,color: Color(h.mainColor),),
                                                              ),
                                                            ),


                                                        ],
                                                      )

                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).size.height*.005
                                                  ),
                                                  child: Text(c.description==null?"":c.description,
                                                    style: TextStyle(height: 1.2,
                                                        fontSize: 10,
                                                        color: Colors.black38),
                                                    maxLines: 2,
                                                  ),
                                                ),


                                              ],),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }


                      )


                  ),
                )

              ],

          )
     ;
  }
  DeleteFromFavorite(BuildContext context,id) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            height: 150.0,
            decoration: BoxDecoration(
              //  border: Border.all(color: Colors.black12,width: 2.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(
                      0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center
                ,crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/icon/about.png",
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 5,),
                  //Confirmdeletionfromfavourite
                  Container(alignment: Alignment.center,child: Text(DemoLocalizations.of(context)
                      .title['Confirmdeletionfromfavourite']
                    ,textAlign: TextAlign.center,)),
                  SizedBox(height: 20,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(

                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:Color(h.blueColor)
                            ),
                            height: MediaQuery.of(context).size.height*.045,
                            width: MediaQuery.of(context).size.width*.33,
                            alignment: Alignment.center,
                            //cancell
                            child:   Text( DemoLocalizations.of(context)
                                .title['cancell']
                              ,style: TextStyle(color:Colors.white,fontSize: 12),),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:Color(h.mainColor)
                            ),
                            height: MediaQuery.of(context).size.height*.045,
                            width: MediaQuery.of(context).size.width*.33,
                            alignment: Alignment.center,
                            child:   Text(DemoLocalizations.of(context)
                                .title['confirm'],style: TextStyle(color:Colors.white,fontSize: 12),),
                          ),
                          onTap: () async {
                            setState(() {
                              db.deleteFavorite(id);
                            });
                            loadData();
                            Navigator.pop(context);
                          },
                        ),

                      ],
                    ),
                  )
                ],
              ),


            ],),
          ),
        ));
  }
  void ProductDetails(int counter,FavoriteModelLocal product,List<SubProductDetail>data) {
    int counter2 = counter;
    SubProductDetail selectedProduct=data[0];
    showDialog(
        context: context,
        builder: (BuildContext context) =>StatefulBuilder(
          builder: (BuildContext context, StateSetter setState)=> Scaffold(
            backgroundColor: Colors.transparent,
            body:  Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(
                  // top: MediaQuery.of(context).size.height*.4
                ),
                color: Colors.transparent,
                child: Container(
                  height: MediaQuery.of(context).size.height*.72,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*.23
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)
                      )),
                  child: Column(
                    children:[
                      Expanded(
                        child: ListView(
                          padding:EdgeInsets.zero,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "images/prodcut4.png",
                                    image:selectedProduct.image==null?"":selectedProduct.image,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height*.32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                    right: 15,
                                    top: 15,
                                    child:GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(1000)),
                                            color: Colors.white
                                        ),
                                        child:  Icon(Icons.clear,size: 20,),
                                      ),
                                    ))
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width*.05,
                                  right:  MediaQuery.of(context).size.width*.05
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: MediaQuery.of(context).size.height*.025,),
                                        Text(selectedProduct.name,style: TextStyle(fontSize: 16,color: Colors.black),),
                                        SizedBox(height: MediaQuery.of(context).size.height*.015,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*.33,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(100)),
                                                        border: Border.all(color: Color(h.mainColor),width: 1.0),
                                                        color: Colors.white
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      child:Icon(Icons.remove,size: 22,color: Color(h.mainColor),),
                                                      onTap: (){
                                                        if(counter>1){
                                                          setState(() {
                                                            counter2=counter2-1;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    width:25,
                                                    height: 32,

                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.only(bottom: 7),
                                                    child: Text("$counter2",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black),),
                                                  ),
                                                  Container(
                                                    width:25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(100)),
                                                        border: Border.all(color: Color(h.blueColor),width: 1.0),
                                                        color: Colors.white
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      child:Icon(Icons.add,size: 22,color: Color(h.blueColor),),
                                                      onTap: (){
                                                        setState(() {
                                                          counter2=counter2+1;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text("${selectedProduct.price2==null?"0":selectedProduct.price2} "+DemoLocalizations.of(context)
                                                .title['currency']
                                              ,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height*.03,),
                                        Text(DemoLocalizations.of(context)
                                            .title['makenote']
                                          ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color(h.blueColor)),),
                                        SizedBox(height: MediaQuery.of(context).size.height*.015,),
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
                                        SizedBox(height: MediaQuery.of(context).size.height*.03,),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                          //right:  MediaQuery.of(context).size.width*.2,
                                          //left:  MediaQuery.of(context).size.width*.2
                                        ),
                                        decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(h.blueColor),
                                        ),
                                        height: MediaQuery.of(context).size.height*.06,
                                        width: MediaQuery.of(context).size.width*.9,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width*.07,
                                          right: MediaQuery.of(context).size.width*.07,
                                        ),
                                        child:   Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${double.parse(selectedProduct.price2)*counter2} "+DemoLocalizations.of(context)
                                                .title['currency']
                                              ,style: TextStyle(color:Colors.white,fontSize: 12),),
                                            Text(DemoLocalizations.of(context)
                                                .title['addtocart']
                                              ,style: TextStyle(color:Colors.white,fontSize: 12),),
                                          ],
                                        )
                                    ),
                                    onTap: () async {
                                      // Navigator.pushNamed(context, '/Cart');
                                      CartMedelLocal p1=new CartMedelLocal({
                                        "id":int.parse(selectedProduct.id),
                                        "name":selectedProduct.name,
                                        "img":selectedProduct.image,
                                        "description":selectedProduct.description,
                                        "price":double.parse(selectedProduct.price),
                                        "price2":double.parse(selectedProduct.price2),
                                        "totalPrice":0.0,
                                        "quantity":counter2
                                      });
                                      try
                                      {
                                        Navigator.pop(context);
                                        addProductDialog(context,counter2);

                                        await dbHelper.addToCart(p1);

                                        /* Toast.show(
                                          "تم اضافة المنتج", context,
                                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);*/

                                      }
                                      catch(e)
                                      {
                                        Navigator.pop(context);
                                        addProductDialog(context,counter2);

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

                      SizedBox(height: 15,)
                    ],
                  ),
                ),


              ),

          ),
        ));
  }
  Widget ProductDetails2(int counter,FavoriteModelLocal product,List<SubProductDetail>data) {
    int counter2 = counter;
    SubProductDetail selectedProduct=data[0];
    showDialog(
        context: context,
        builder: (BuildContext context) =>StatefulBuilder(
          builder: (BuildContext context, StateSetter setState)=> Scaffold(
            body:  Container(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*.05,
                      right:  MediaQuery.of(context).size.width*.05
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)
                      )),
                  child: Column(
                    children:[
                      Expanded(
                        child: ListView(
                          padding:EdgeInsets.zero,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height*.01,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.black12
                              ),
                              width: MediaQuery.of(context).size.width*.1,
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width*.37,
                                  right: MediaQuery.of(context).size.width*.37
                              ),
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.keyboard_arrow_down,size: 30,color: Color(h.mainColor),)),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.005,),
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: FadeInImage.assetNetwork(
                                placeholder: "images/prodcut4.png",
                                image:product.img==null?"":product.img,
                                width: MediaQuery.of(context).size.width*.9,
                                height: MediaQuery.of(context).size.height*.17,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height*.025,),
                                  Text(product.title,style: TextStyle(fontSize: 16,color: Colors.black),),
                                  SizedBox(height: MediaQuery.of(context).size.height*.005,),
                                  Text(product.description,style: TextStyle(fontSize: 12,color: Colors.black54),),
                                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*.33,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  border: Border.all(color: Color(h.mainColor),width: 1.0),
                                                  color: Colors.white
                                              ),
                                              alignment: Alignment.center,
                                              child: InkWell(
                                                child:Icon(Icons.remove,size: 22,color: Color(h.mainColor),),
                                                onTap: (){
                                                  if(counter>1){
                                                    setState(() {
                                                      counter2=counter2-1;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            Container(
                                              width:25,
                                              height: 32,

                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(bottom: 7),
                                              child: Text("$counter2",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black),),
                                            ),
                                            Container(
                                              width:25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  border: Border.all(color: Color(h.blueColor),width: 1.0),
                                                  color: Colors.white
                                              ),
                                              alignment: Alignment.center,
                                              child: InkWell(
                                                child:Icon(Icons.add,size: 22,color: Color(h.blueColor),),
                                                onTap: (){
                                                  setState(() {
                                                    counter2=counter2+1;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text("${selectedProduct.price2==null?"0":selectedProduct.price2}  "+DemoLocalizations.of(context)
                                          .title['currency']
                                        ,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.025,),
                                  Row(
                                    children: [
                                      //Choosetherighttype
                                      Text(DemoLocalizations.of(context)
                                          .title['Choosetherighttype']
                                          ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color(h.blueColor))),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    // padding:EdgeInsets.only(top:5,bottom:5),
                                    padding: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black12,width: 1),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.1),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    margin:EdgeInsets.only(
                                      //left:MediaQuery.of(context).size.width*.05,
                                      //right: MediaQuery.of(context).size.width*.05,
                                    ),
                                    child: ListView.builder(itemCount: data.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemBuilder: (context,index){
                                          return Container(
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    setState((){
                                                      selectedProduct= data[index];
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(data[index].name,style: TextStyle(fontSize: 12,color: Colors.black)),
                                                      Radio(value: data[index],groupValue: selectedProduct,onChanged: (val){
                                                        print(val);
                                                        print("sssssssssssssssss");
                                                        setState((){
                                                          selectedProduct=val;
                                                        });
                                                      },),
                                                    ],
                                                  ),
                                                ),
                                                Container(height: 1,
                                                  width: MediaQuery.of(context).size.width,
                                                  color: Colors.black12,
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.025,),
                                  Text(DemoLocalizations.of(context)
                                      .title['makenote']
                                    ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color(h.blueColor)),),
                                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
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
                                            .title['Wouldyouliketotellusanythingelse']
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
                                  SizedBox(height: MediaQuery.of(context).size.height*.03,),
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
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(h.blueColor),
                            ),
                            height: MediaQuery.of(context).size.height*.06,
                            width: MediaQuery.of(context).size.width*.9,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width*.07,
                              right: MediaQuery.of(context).size.width*.07,
                            ),
                            child:   Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${double.parse(selectedProduct.price2)*counter2}"+DemoLocalizations.of(context)
                                    .title['currency'],style: TextStyle(color:Colors.white,fontSize: 12),),
                                Text(DemoLocalizations.of(context)
                                    .title['addtocart']
                                  ,style: TextStyle(color:Colors.white,fontSize: 12),),
                              ],
                            )
                        ),
                        onTap: () async {
                          // Navigator.pushNamed(context, '/Cart');
                          CartMedelLocal p1=new CartMedelLocal({
                            "id":int.parse(selectedProduct.id),
                            "name":selectedProduct.name,
                            "img":selectedProduct.image,
                            "description":selectedProduct.description,
                            "price":double.parse(selectedProduct.price),
                            "price2":double.parse(selectedProduct.price2),
                            "totalPrice":0.0,
                            "quantity":counter2
                          });
                          try
                          {
                            Navigator.pop(context);
                            addProductDialog(context,counter2);

                            await dbHelper.addToCart(p1);

                            /* Toast.show(
                                        "تم اضافة المنتج", context,
                                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);*/

                          }
                          catch(e)
                          {
                            Navigator.pop(context);
                            addProductDialog(context,counter2);

                            dbHelper.updateCourse(p1);

                          }
                        },
                      ),
                      SizedBox(height: 15,)
                    ],
                  ),
                ),


              ),

          ),
        ));
  }
  addProductDialog(BuildContext context,int count) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            height: 150.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                border: Border.all(color: Colors.black12,width: 2.0),
                color: Colors.white
            ),
            child: Stack(children: <Widget>[
              Column(
                //mainAxisAlignment: MainAxisAlignment.center
                // ,crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(alignment: Alignment.center,child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Container(

                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                                  color: Colors.white
                              ),
                              padding:EdgeInsets.all(3),
                              child: Icon(Icons.clear,color: Colors.white,size: 18,),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              child: Icon(Icons.check_circle_outline,size: 50,color: Color(h.mainColor),),
                            ),

                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                                    color: Color(h.mainColor)
                                ),
                                padding:EdgeInsets.all(2.5),
                                child: Icon(Icons.clear,color: Colors.white,size: 20,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10,),
                      //Successfullyadded
                      Text(DemoLocalizations.of(context)
                          .title['Successfullyadded']
                        ,style: TextStyle(color: Color(h.blueColor),fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      Text(DemoLocalizations.of(context)
                          .title['qunt']
                        +" $count",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      // Text("${title}",textAlign: TextAlign.center,)
                    ],
                  )),
                ],
              ),


            ],),
          ),
        ));
  }
}

