import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/app/Services/ConfigServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:toast/toast.dart';
import '../main.dart';

class ContactUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<ContactUs> {
  home h = new home();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController message = new TextEditingController();
  FocusNode nameNode = new FocusNode();
  FocusNode emailNode = new FocusNode();
  FocusNode phoneNode = new FocusNode();
  FocusNode messageNode = new FocusNode();
  ConfigServices configServices = new ConfigServices();
  Map<String, dynamic> data;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (home.username != null) {
      setState(() {
        name.text = home.username;
        email.text = home.email;
        phone.text = home.phone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Color(0xffD4252F),
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: DemoLocalizations.of(context).locale == Locale("en")
                    ? Icon(Icons.arrow_back_ios_rounded,
                        size: 25, color: Colors.white)
                    : Icon(Icons.arrow_forward_ios_rounded,
                        size: 25, color: Colors.white)),
            Expanded(
              child: Text(
                DemoLocalizations.of(context).title['contact_us'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      //   endDrawer: MyDrawer(7),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Container(
                child: Image.asset(
                  "images/logo.png",
                  height: MediaQuery.of(context).size.height * .2,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .05,
                    right: MediaQuery.of(context).size.width * .05),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(emailNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              //Entertheusername
                              return DemoLocalizations.of(context)
                                  .title['Entertheusername']
                              ;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(h.mainColor)),
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black45),
                            contentPadding: EdgeInsets.only(
                                right: 15, left: 15, top: 10, bottom: 10),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(h.borderColor))),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.FocusBorderColor))),
                            focusedErrorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            errorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            hintText:DemoLocalizations.of(context)
                                .title['name'],
                            prefixIcon: Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.black45,
                            ),
                          ),
                          controller: name,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .017,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(phoneNode);
                          },
                          focusNode: emailNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              //emailrequired
                              return DemoLocalizations.of(context)
                                  .title['emailrequired']
                              ;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(h.mainColor)),
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black45),
                            contentPadding: EdgeInsets.only(
                                right: 15, left: 15, top: 10, bottom: 10),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(h.borderColor))),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.FocusBorderColor))),
                            focusedErrorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            errorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            hintText: DemoLocalizations.of(context)
                                .title['email'],
                            prefixIcon: Icon(
                              Icons.markunread,
                              size: 20,
                              color: Colors.black45,
                            ),
                          ),
                          controller: email,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .017,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(messageNode);
                          },
                          focusNode: phoneNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              ///
                              return DemoLocalizations.of(context)
                                  .title['phonerequired']
                              ;
                            }
                            return null;
                          },
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(h.mainColor)),
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black45),
                            contentPadding: EdgeInsets.only(
                                right: 15, left: 15, top: 10, bottom: 10),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(h.borderColor))),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.FocusBorderColor))),
                            focusedErrorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            errorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            hintText: DemoLocalizations.of(context)
                                .title['phone'],
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 20,
                              color: Colors.black45,
                            ),
                          ),
                          controller: phone,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .017,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          focusNode: messageNode,
                          validator: (value) {
                            if (value.isEmpty) {

                              return DemoLocalizations.of(context)
                                  .title['entersms'];
                            }
                            return null;
                          },
                          maxLines: 4,
                          minLines: 3,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(h.mainColor)),
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black45),
                            contentPadding: EdgeInsets.only(
                                right: 15, left: 15, top: 10, bottom: 10),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(h.borderColor))),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.FocusBorderColor))),
                            focusedErrorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            errorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(h.ErorrBorderColor))),
                            //message
                            hintText: DemoLocalizations.of(context)
                                .title['message']
                            ,
                            //prefixIcon: Icon(Icons.https_rounded,size: 20,color: Colors.white,),
                          ),
                          controller: message,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState.validate()) {
                    data = await configServices.ContactUsServices(
                        name.text, phone.text, email.text, message.text);
                    print(data);
                    print("00000000000000");
                    if (data["StatusCode"] == 200) {
                      MessageSend(context);
                      Timer(Duration(seconds: 2), () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/mainPage', (Route<dynamic> route) => false);
                      });
                    } else {
                      //Failedtosendmessage
                      Toast.show(DemoLocalizations.of(context)
                          .title['Failedtosendmessage']
                          , context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .05,
                      right: MediaQuery.of(context).size.width * .05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(h.blueColor),
                  ),
                  height: MediaQuery.of(context).size.height * .065,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    DemoLocalizations.of(context)
                        .title['confirm']
                    ,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ),
    ));
  }

  MessageSend(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 130.0,
                width: MediaQuery.of(context).size.width * .6,
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
                                  padding: EdgeInsets.only(top: 13),
                                  child: Icon(
                                    Icons.check_circle_outline,
                                    size: 50,
                                    color: Color(h.mainColor),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  DemoLocalizations.of(context)
                                      .title['Messagesentsuccessfully']
                                  ,
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
