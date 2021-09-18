import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/app/Services/AddressServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:toast/toast.dart';
import '../main.dart';
import 'GlobalFunction.dart';
import 'AddAddress.dart';
import '../Model/AddressModel.dart';
import 'package:mishwar/lang/app_Localization.dart';


class Adresses extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State <Adresses>{
  home h=new home();
  List<AddressModel>addressList;
  AddressServices addressServices=new AddressServices();
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
   addressList=await addressServices.GetAddresses(prefs.getString("UserId"));
  //  addressList=await addressServices.GetAddresses('4');
     setState(() {
    });
    print(addressList);
    print("4444444444444444");
  }
  int selected=1;
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      key: _scaffoldKey,
      //endDrawer: MyDrawer(3),
      body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                              Navigator.of(context).pop();
                            },

                            child: DemoLocalizations.of(context).locale == Locale("en")
                                ? Icon(Icons.arrow_back_ios_rounded, size: 25, color:Colors.white)
                                : Icon(Icons.arrow_forward_ios_rounded,
                                size:25, color:Colors.white)),
                         Text( DemoLocalizations.of(context)
                            .title['listaddresses'],style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                        GestureDetector(
                            onTap: (){
                            },
                            child: Icon(Icons.arrow_forward_outlined,color: Color(h.mainColor),size: 25,))
                      ],
                    ),
                  ),

                ),
                SizedBox(height: MediaQuery.of(context).size.height*.025,),
               GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.routeBottom(AddAddress("add")));
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
                            color: Color(h.blueColor)
                            //  border: Border.all(width: 1.0,color: Colors.black26)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/plus.png",width: 18,color: Colors.white,),
                              SizedBox(width:15),
                              Text(DemoLocalizations.of(context).title['addnewadrress'],style: TextStyle(fontSize: 12,color: Colors.white),),

                            ],
                          )
                        ),
                      )

                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.025,),
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
                                    Text(DemoLocalizations.of(context).title['phone']+" : ${addressList[index].phone1}",style: TextStyle(fontSize: 11,color: Colors.black87.withOpacity(.6)),)
                                  ],
                                ),
                                 Column(
                                   children: [
                                     GestureDetector(
                                         onTap:()async{
                                           print("sssssssssssss");
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
                                     SizedBox(height: 18,),
                                     GestureDetector(
                                         onTap:(){
                                           if(addressList[index].isPrimary=="0")
                                           confirmDelete(context,addressList[index].id);
                                           else{
                                             Toast.show(
                                               //Favoritetitleannotbeerased
                                                 DemoLocalizations.of(context).title['Favoritetitleannotbeerased'], context,
                                                 duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                           }
                                         },
                                         child: Icon(Icons.delete,color: Color(h.mainColor),size: 32,),

                                     )
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
                      SizedBox(height: MediaQuery.of(context).size.height*.1,),
                      Image.asset("images/noAddress.png",
                      height: MediaQuery.of(context).size.height*.25,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                      //nologdata
                      Text(DemoLocalizations.of(context).title['nologdata'],style: TextStyle(fontSize: 12,color: Colors.black45),),
                      SizedBox(height: MediaQuery.of(context).size.height*.07,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, GlobalFunction.routeBottom(AddAddress("add")));
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
                                      Text(DemoLocalizations.of(context).title['addnewadrress'],style: TextStyle(fontSize: 12,color: Colors.black54),),

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


    ));
  }
  confirmDelete(BuildContext context,var id) {
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
                mainAxisAlignment: MainAxisAlignment.center
                ,crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(alignment: Alignment.center,child: Column(
                    children: [
                      Image.asset("images/icon/about.png",
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 5,),
                      //Confirmdeletionofthisaddress
                      Text(DemoLocalizations.of(context).title['Confirmdeletionofthisaddress'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      // Text("${title}",textAlign: TextAlign.center,)
                    ],
                  )),
                  SizedBox(height: 20,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(

                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black38,width: 1.0),
                                color:Colors.white
                            ),
                            height: MediaQuery.of(context).size.height*.045,
                            width: MediaQuery.of(context).size.width*.32,
                            alignment: Alignment.center,
                            child:   Text(DemoLocalizations.of(context).title['cancell'],style: TextStyle(color:Colors.black,fontSize: 13),),
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
                            width: MediaQuery.of(context).size.width*.32,
                            alignment: Alignment.center,
                            child:   Text(DemoLocalizations.of(context).title['confirm'],style: TextStyle(color:Colors.white,fontSize: 13),),
                          ),
                          onTap: () async {
                            Map<String,dynamic>responce=await addressServices.deleteAddress(id);
                            print(responce);
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
}