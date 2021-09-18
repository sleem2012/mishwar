import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Model/NotificationModel.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import 'package:mishwar/app/Services/UserServices.dart';
 import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../CustomAppBar.dart';


class DeliverNotifications extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State <DeliverNotifications>{
  home h=new home();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List <NotificationDetail>data;
  UserServices userServices=new UserServices();
  var user_id;
  loadData() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    setState(() {
      user_id=pref.getString("UserId");
    });
    if(pref.getString("UserId")!=null){
      data=await userServices.GetNotifiction(pref.getString("UserId"));
      setState(() {
      });
      print(data.length);
      print("000000000000000000000000000000000000000000000000000000");
    }
    else{
      print("sssssssssssss");
      setState(() {
        data=[];
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return  data==null?Expanded(child: Center(child: CircularProgressIndicator(),)):data.length==0||home.username==null?Expanded(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.2,),
            Icon(Icons.notifications_off_outlined,size: 200,color: Colors.black54,),
            Text(user_id==null?"برجاء تسجيل الدخول":"لا يوجد اشعارات",style: TextStyle(fontSize: 22,color: Colors.black54),)
          ],
        ),
      ),
    ):Expanded(
      child: Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*.035,
            right: MediaQuery.of(context).size.width*.035,
            top: MediaQuery.of(context).size.height*.02,

          ),
          //height: MediaQuery.of(context).size.height*.8,
          child: ListView.builder(
              itemCount: data.length,
              padding: EdgeInsets.only(
                bottom:  MediaQuery.of(context).size.height*.04,
              ),
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height*.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black12,width: 1.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*.04,
                      right: MediaQuery.of(context).size.width*.04,
                      top: MediaQuery.of(context).size.height*.0135,
                      bottom: MediaQuery.of(context).size.height*.0135
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(1000)),
                                color: Color(h.mainColor)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.notifications,color: Colors.white,size: 30,),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index].title,style: TextStyle(height: 1.4,fontSize: 14,color: Colors.black45),),
                              //SizedBox(height: 2,),
                               Text(data[index].description,style: TextStyle(height: 1.4,fontSize: 9,color: Colors.black45),),
                              SizedBox(height: 2.5,),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(data[index].createdAt,textDirection: TextDirection.ltr,style: TextStyle(height: 1.5,color: Colors.black45,fontSize: 9),),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              })),
    );
  }
}