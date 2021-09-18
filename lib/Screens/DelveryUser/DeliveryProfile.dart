import 'dart:io';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mishwar/app/Services/GlobalVariables.dart';
import 'package:mishwar/app/Services/UserServices.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../main.dart';

class DeliveryProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return editProfileState();
  }
}

class editProfileState extends State<DeliveryProfile> {
  final emailNode=FocusNode();
  final passwordNode=FocusNode();
  final phoneNode=FocusNode();
  final locationNode=FocusNode();
  final birthNode=FocusNode();
  bool passVisibility=true;
  final formKey=GlobalKey<FormState>();
  home h=new home();

  TextEditingController name=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController date=new TextEditingController();
  var UserId;
  UserServices userServices=new UserServices();
  Map<String,dynamic>data;
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    data=await userServices.getUserData(prefs.getString("UserId"));
    name.text=data["Message"]["name"];
    phone.text=data["Message"]["phone"];
    email.text=data["Message"]["email"];
    setState(() {
      UserId=prefs.getString("UserId");
    });
    print(data);
    print("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    print(data["Message"]["image"]);
    print("************************************************************************************************");
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }
  @override
  void dispose() {
    name.dispose();
    password.dispose();
    email.dispose();
    phone.dispose();
    date.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return data==null?Expanded(child: Center(child:CircularProgressIndicator()),):Expanded(
      child:  ListView(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * .05,
            left: MediaQuery.of(context).size.width * .05,
            //top: MediaQuery.of(context).size.height * .03
          ),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height *.05,),
            Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: (){
                    pickImage(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(1000)),
                    child: FadeInImage.assetNetwork(
                      placeholder:"images/Photo.png",
                      image:data["Message"]["image"]==null?"https://tse4.mm.bing.net/th?id=OIP.T2ILd2qLXwqlcImvKtXcGgAAAA&pid=Api&P=0&w=171&h=168":data["Message"]["image"],
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.width * .3,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                    top:MediaQuery.of(context).size.width*.2,
                    left: MediaQuery.of(context).size.width*.5,
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xff00e096)
                      ),
                      child: Center(
                        child: GestureDetector(
                          child: Icon(Icons.add,color: Colors.white,size: 20,),
                        ),
                      ),
                    ))
              ],

            ),
            SizedBox(height: MediaQuery.of(context).size.height *.05,),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(padding: EdgeInsets.only(left: 10.0,right: 10.0),
                    decoration: BoxDecoration(border: Border.all(width: 1.0,color: Color(h.borderColor)),
                      borderRadius:BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Text(DemoLocalizations.of(context)
                            .title['username']
                          ,style: TextStyle(color: Colors.black54,fontSize: 12),),

                        SizedBox(width: 10.0,),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (value){
                              FocusScope.of(context).requestFocus(passwordNode);
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return DemoLocalizations.of(context)
                                    .title['usernamerequired']
                                ;
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black54,fontSize: 12),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10),
                              border: InputBorder.none,

                            ),
                            controller: name,
                          ),
                        ),
                        SizedBox(width: 10.0,),

                        Icon(Icons.arrow_forward_ios,size: 18,color: Colors.black54,)
                      ],
                    ),
                  ),
                  /*  SizedBox(height: MediaQuery.of(context).size.height *.017,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        onFieldSubmitted: (value){
                          FocusScope.of(context).requestFocus(phoneNode);
                        },
                        focusNode: passwordNode,
                        obscureText: passVisibility,
                        validator: (value){
                          if(value.isEmpty){
                            return 'password is required';
                          }
                          return null;
                        },
                        style:TextStyle(color: Colors.black54,fontSize: 12),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10),
                          enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(h.borderColor))
                          ),
                          focusedBorder:  new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(h.borderColor))
                          ),
                          focusedErrorBorder:new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(h.borderColor))
                          ),
                          errorBorder:new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(h.borderColor))
                          ),
                          prefix: Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width*.30,
                            child: Text("كلمة المرور :",style: TextStyle(color: Colors.black54,fontSize: 12),),
                          ),
                          suffixIcon: Icon(Icons.arrow_forward_ios,size: 18,color: Colors.black54,),
                        ),
                        controller: password,
                      ),
                    ),*/
                  SizedBox(height: MediaQuery.of(context).size.height *.017,),
                  Container(padding: EdgeInsets.only(left: 10.0,right: 10.0),
                    decoration: BoxDecoration( border: Border.all(width: 1.0,color: Color(h.borderColor)),
                      borderRadius:BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Text(DemoLocalizations.of(context)
                            .title['phone']
                          ,style: TextStyle(color: Colors.black54,fontSize: 12),),
                        SizedBox(width: 10.0,),

                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value){
                              FocusScope.of(context).requestFocus(emailNode);
                            },
                            focusNode: phoneNode,
                            validator: (value){
                              if(value.isEmpty){
                                //phonerequired
                                return DemoLocalizations.of(context)
                                    .title['phonerequired']
                                ;
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black54,fontSize: 12),
                            decoration: InputDecoration(
                              border: InputBorder.none,

                            ),
                            controller: phone,
                          ),
                        ),  SizedBox(width: 10.0,),
                        Icon(Icons.arrow_forward_ios,size: 18,color: Colors.black54,)
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height *.017,),
                  Container(padding: EdgeInsets.only(left: 10.0,right: 10.0),
                    decoration: BoxDecoration(border: Border.all(width: 1.0,color: Color(h.borderColor)),
                      borderRadius:BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Text(DemoLocalizations.of(context)
                              .title['email']
                            ,maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 12),),
                        ), SizedBox(width: 10.0,),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (value){
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            focusNode: emailNode,
                            validator: (value){
                              if(value.isEmpty){
                                return DemoLocalizations.of(context)
                                    .title['emailrequired']
                                ;
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black54,fontSize: 12),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10),
                              border: InputBorder.none,

                            ),
                            controller: email,
                          ),
                        ),


                        SizedBox(width: 10.0,),
                        Icon(Icons.arrow_forward_ios,size: 18,color: Colors.black54,)
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height *.03,),
                  SizedBox(height: MediaQuery.of(context).size.height *.05,),
                  InkWell(
                    child: Container(
                      height:MediaQuery.of(context).size.height *.06,
                      width: MediaQuery.of(context).size.width *.6,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(h.blueColor)
                      ),
                      child: Text(DemoLocalizations.of(
                          context)
                          .title[
                      'save']
                        , style: TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                    onTap: ()async{
                      if(formKey.currentState.validate())
                      {
                        Map<String,dynamic>responce=await userServices.updateProfile(UserId, name.text, email.text, phone.text);
                        if(responce["StatusCode"]==200)
                          //Yourpersonaldatahasbeenmodifiedsuccessfully
                        {
                          Toast.show(
                            //Pleasechooseadeliverymethod
                              DemoLocalizations.of(context)
                                  .title['Yourpersonaldatahasbeenmodifiedsuccessfully'],
                              context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                          Navigator.pushNamedAndRemoveUntil(context, "/DeleverMain", (route) => false);
                        }
                        else{
                          Toast.show(
                              "${responce["Message"]}", context,
                              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),

          ],
        ),

    );
  }
  File selectedImage;
  pickImage(BuildContext context ) async {
    var profileImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = profileImage;
    });
    sendImagePick(selectedImage,context);

  }
  sendImagePick(File fileImage,BuildContext context)async
  {
    if (fileImage != null) {
      try {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        Dio dio = Dio();
        ///we used uri.encode to enable upload  image with arabic name
        // var url =Uri.encodeFull(createPath('user/editProfileImage'));
        var url = "${GlobalVariables.URL}/user/changeAvatar";
        print(url);
        String fileName = basename(fileImage.path);
        // print('${fileName},,,,fileName');
        //print('${pathImage.path},,,,imagePath.path');

        FormData formData = FormData.fromMap({
          "avatar": await MultipartFile.fromFile(
              fileImage.path, filename: fileName
              , contentType: MediaType('image', fileName
              .split('.')
              .last)),
          "user_id": int.parse(UserId)/*int.parse(sharedPreferences.getString('UserID'))*/,
        });
        print(formData.fields);
        print("ssssssssssssssssss");
        Response response = await dio.post(url, data: formData);
        print('${response.data},,,,,,,,fields');
        if (response.statusCode == 200) {
          Map<String, dynamic>map = response.data;
          Toast.show(
              map['Data'], context,
              duration: Toast.LENGTH_SHORT,
              gravity: Toast.BOTTOM);
          loadData();

        }
        else {
          return null;
        }
      }
      catch (e) {
        print('${e}imageuploaderror');
      }
    }
    else {
      pickImage(context);
    }}
}
