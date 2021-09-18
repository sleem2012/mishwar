import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/app/Services/UserServices.dart';
 import 'ResetForgetPassword.dart';
import '../main.dart';
import 'GlobalFunction.dart';
import 'package:mishwar/lang/app_Localization.dart';

class verification extends StatefulWidget {
  String type;
  String phone;
  @override
  verification(String type,String phone){
    this.type=type;
    this.phone=phone;
  }
  State<StatefulWidget> createState() {
    return verificationState(type,this.phone);
  }
}

class verificationState extends State<verification> {

  String phone;
  String type;
  Map<String,dynamic> data;
  verificationState(String type,String phone){
    this.type=type;
    this.phone=phone;
  }
  UserServices userServices=new UserServices();
  home h = new home();
  String error;
  final foemKey = GlobalKey<FormState>();
  TextEditingController n1=new TextEditingController();
  TextEditingController n2=new TextEditingController();
  TextEditingController n3=new TextEditingController();
  TextEditingController n4=new TextEditingController();
  TextEditingController n5=new TextEditingController();
  TextEditingController n6=new TextEditingController();
  final nod0 = FocusNode();
  final nod1 = FocusNode();
  final nod2 = FocusNode();
  final nod3 = FocusNode();
  final nod4 = FocusNode();
  final nod5 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(h.whiteColor),
  /*      appBar: AppBar(
          backgroundColor: Color(h.whiteColor),
          elevation: 0,
          iconTheme: IconThemeData(
              color:Colors.black87
          ),
        ),*/
        body:  Container(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.12,),
                Image.asset("images/logo.png",
                  height: MediaQuery.of(context).size.height*.2,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Text( DemoLocalizations.of(context)
                    .title['activaccount']
                  ,style: TextStyle(color: Color(h.mainColor),fontSize: 17,fontWeight: FontWeight.bold),),
                SizedBox(height: MediaQuery.of(context).size.height*.022,),
                Container(
                  width: MediaQuery.of(context).size.width*.6,
                  child:Column(
                    children: [
                      //
                      Text( DemoLocalizations.of(context)
                          .title['entertheccode'],style: TextStyle(height: 1.0),textAlign: TextAlign.center,),
                      SizedBox(height: 5,),
                      //whicissent
                      Text(DemoLocalizations.of(context)
                          .title['whicissent'],style: TextStyle(height: 1.0),textAlign: TextAlign.center,),
                      SizedBox(height: 5,),
                      Text(phone,style: TextStyle(height: 1.0),textAlign: TextAlign.center,),
                    ],
                  )
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.03,),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.05,
                        right: MediaQuery.of(context).size.width*.05,
                      ),
                      child: ListView(
                        children: [
                          Form(
                            key: foemKey,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextFormField(
                                    autofocus: true,
                                    focusNode: nod0,
                                    maxLength: 1,
                                    onChanged:(val) {
                                      if(val.isEmpty){

                                      }else
                                        FocusScope.of(context).requestFocus(nod1);
                                    },
                                    //  onFieldSubmitted:
                                    validator: (value) {
                                      if (value.isEmpty) return 'Error';
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: Color(h.borderColor))),
                                      focusedBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.FocusBorderColor))),
                                      errorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                      counterStyle: TextStyle(fontSize: 0),
                                    ),
                                    controller: n1,

                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextFormField(
                                    maxLength: 1,
                                    onChanged: (val) {
                                      if(val.isEmpty){
                                        print("00000000000000000000000000000000");
                                        FocusScope.of(context).requestFocus(nod0);
                                      }else
                                        FocusScope.of(context).requestFocus(nod2);
                                    },
                                    focusNode: nod1,
                                    validator: (value) {
                                      if (value.isEmpty) return 'Error';
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 0),
                                      counterStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: Color(h.borderColor))),
                                      focusedBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.FocusBorderColor))),
                                      errorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                    ),
                                    controller: n2,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextFormField(
                                    maxLength: 1,
                                    onChanged: (val) {
                                      if(val.isEmpty){
                                        FocusScope.of(context).requestFocus(nod1);
                                      }else
                                        FocusScope.of(context).requestFocus(nod3);
                                    },
                                    focusNode: nod2,
                                    validator: (value) {
                                      if (value.isEmpty) return 'Error';
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      counterStyle: TextStyle(fontSize: 0),
                                      errorStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: Color(h.borderColor))),
                                      focusedBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.FocusBorderColor))),
                                      errorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                    ),
                                    controller: n3,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextFormField(
                                    maxLength: 1,
                                    validator: (value) {
                                      if (value.isEmpty) return 'Error';
                                      return null;
                                    },
                                    focusNode: nod3,
                                    onChanged: (val) {
                                      if(val.isEmpty){
                                        FocusScope.of(context).requestFocus(nod2);
                                      }else
                                        FocusScope.of(context).requestFocus(nod4);
                                    },
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 0),
                                      counterStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: Color(h.borderColor))),
                                      focusedBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.FocusBorderColor))),
                                      errorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                    ),
                                    controller: n4,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextFormField(
                                    maxLength: 1,
                                    validator: (value) {
                                      if (value.isEmpty) return 'Error';
                                      return null;
                                    },
                                    focusNode: nod4,
                                    onChanged: (val) {
                                      if(val.isEmpty){
                                        FocusScope.of(context).requestFocus(nod3);
                                      }else
                                        FocusScope.of(context).requestFocus(nod5);
                                    },
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 0),
                                      counterStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: Color(h.borderColor))),
                                      focusedBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.FocusBorderColor))),
                                      errorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                    ),
                                    controller: n5,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextFormField(
                                    maxLength: 1,
                                    validator: (value) {
                                      if (value.isEmpty) return 'Error';
                                      return null;
                                    },
                                    focusNode: nod5,
                                    onChanged: (val) {
                                      if(val.isEmpty){
                                        FocusScope.of(context).requestFocus(nod4);
                                      }else
                                        FocusScope.of(context).requestFocus(FocusNode());

                                    },
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      counterStyle: TextStyle(fontSize: 0),
                                      errorStyle: TextStyle(fontSize: 0),
                                      contentPadding: EdgeInsets.only(top: 5, bottom: 0),
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: Color(h.borderColor))),
                                      focusedBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.FocusBorderColor))),
                                      errorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))),
                                    ),
                                    controller: n6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .05,
                          ),
                           error==null?SizedBox():
                               Container(
                                   width: MediaQuery.of(context).size.width,
                                   padding: EdgeInsets.only(bottom: 10),
                                   alignment: Alignment.center,
                                   child: Text(error,style: TextStyle(fontSize: 12,color: Color(h.ErorrBorderColor),fontWeight: FontWeight.bold),)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .013,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(h.blueColor),
                            ),
                            height: MediaQuery.of(context).size.height * .06,
                            width: MediaQuery.of(context).size.width * .9,
                            child: FlatButton(
                              child: Text(
                                DemoLocalizations.of(context)
                                    .title['confirm']
                                ,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async =>
                              {

                                if (foemKey.currentState.validate()){
                                  if(type=="register")
                                    {
                                      data=await userServices.mobileActivation(phone, n1.text+n2.text+n3.text+n4.text+n5.text+n6.text),
                                      if(data["StatusCode"]==200)
                                        Navigator.pushNamedAndRemoveUntil(context, "/VerificationDone", (route) => false)
                                      else{
                                        setState((){
                                          error=data["Message"];
                                        })
                                      }
                                    }
                                  // Navigator.pushNamedAndRemoveUntil(context, "/VerificationDone", (route) => false)
                                  else{
                                    data=await userServices.CheckCode(phone, n1.text+n2.text+n3.text+n4.text+n5.text+n6.text),
                                    if(data["StatusCode"]==200)
                                      Navigator.push(context, GlobalFunction.routeBottom(ResetForgetPassword(this.phone,n1.text+n2.text+n3.text+n4.text+n5.text+n6.text)))
                                    else{
                                      setState((){
                                        error=data["Message"];
                                      })
                                    }
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )),

      ),
    );
  }
}
