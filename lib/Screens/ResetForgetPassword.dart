import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/app/Services/UserServices.dart';

import '../main.dart';
class ResetForgetPassword extends StatefulWidget{
  var phone;
  var code;
  ResetForgetPassword(var phone,var code){
    this.phone=phone;
    this.code=code;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.phone,this.code);
  }
}
class _state extends State<ResetForgetPassword>{
  var phone;
  var code;
  _state(var phone,var code){
    this.phone=phone;
    this.code=code;
  }
  String error;
  bool isError=false;
  var key="+966";
  UserServices userServices=new UserServices();
  home h=new home();
  bool passVisibility=true;
  bool passVisibility2=true;
  final passwordNode=FocusNode();
  final formKey=GlobalKey<FormState>();
  TextEditingController verifyPassword=new TextEditingController();
  TextEditingController password=new TextEditingController();
  Map<String,dynamic>responce;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(h.whiteColor),

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*.08,
              right: MediaQuery.of(context).size.width*.08),
          child: ListView(
            //margin:
            //child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height*.15,),
              Image.asset("images/logo.png",height: MediaQuery.of(context).size.height*.23,),
              SizedBox(height: 30,),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        onFieldSubmitted: (value){
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        obscureText: passVisibility,
                        validator: (value){
                          if(value.isEmpty){
                            return 'ادخل كلمة المرور';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(h.mainColor)),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black45),
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
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                          ),
                          errorBorder:new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                          ),
                          hintText: "كلمة المرور",
                          prefixIcon: Icon(Icons.https_rounded,size: 20,color: Colors.black45,),
                          suffixIcon:InkWell(
                            child: Icon(passVisibility?Icons.visibility:Icons.visibility_off,color: Colors.black45,),
                            onTap: (){
                              setState(() {
                                passVisibility=!passVisibility;
                              });
                            },
                          ) ,
                        ),
                        controller: password,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        onFieldSubmitted: (value){
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        focusNode: passwordNode,
                        obscureText: passVisibility2,
                        validator: (value){
                          if(value.isEmpty){
                            return 'ادخل كلمة المرور';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(h.mainColor)),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black45),
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
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                          ),
                          errorBorder:new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                          ),
                          hintText: "تاكيد كلمة المرور ",
                          prefixIcon: Icon(Icons.https_rounded,size: 20,color: Colors.black45,),
                          suffixIcon:InkWell(
                            child: Icon(passVisibility2?Icons.visibility:Icons.visibility_off,color: Colors.black45,),
                            onTap: (){
                              setState(() {
                                passVisibility2=!passVisibility2;
                              });
                            },
                          ) ,
                        ),
                        controller: verifyPassword,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25,),

              error==null?SizedBox():Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(error,style: TextStyle(color: Color(h.ErorrBorderColor),fontSize: 12),)),
              SizedBox(height: 10,),
              GestureDetector(
                onTap:() async =>{
                  if(formKey.currentState.validate()){
                    responce=await userServices.changeForgetPassword(phone, code, password.text, verifyPassword.text),
                    print(responce),
                    if(responce["StatusCode"]==200){
                        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false),
                    }else{
                      setState((){
                        error=responce["Message"];
                      }),
                    }

                    //setData("UserId","12"),
                  }
                  else{
                    setState((){
                      isError=true;
                    })
                  }
                },
                child: Container(
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),color: Color(h.blueColor),),
                  height: MediaQuery.of(context).size.height*.06,
                  width: MediaQuery.of(context).size.width*.6,
                  alignment: Alignment.center,
                  child: Text("تاكيد",style: TextStyle(color:Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(height: 600,),








            ],
            //  ),
          ),
        ),
      ),
    );
  }
}