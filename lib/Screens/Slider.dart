import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mishwar/lang/app_Localization.dart';
import '../main.dart';
import 'CustomText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'GlobalFunction.dart';
import 'HomePage.dart';
import 'package:mishwar/app/AppConfig.dart';

class slider extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return homePageState();
  }

}
class homePageState extends State<slider>{
  home h=new home();
  var branch_id;
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      branch_id=prefs.getString("branch_id");
    });
    print(branch_id);
    print("ssssssssssss");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  List <String> image=["images/slider/1.png","images/slider/2.png","images/slider/3.png",];
  List <String> title=["ابحث عن وجبتك المفضلة لدينا","اسرع خدمة توصيل","تتبع طلبك عبر الخريطة",];
  List <String> subtitle=["اكتشف وجبتك المفضلة ","تمكن من خدمة التوصيل الي منزلك او مكتبك او اي مكان تحب",
    "اكتشف وجبتك المفضلة عبر مجموعة مميزة من الوجبات",];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
          children: [
            Container(
              decoration:BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),color: Colors.white,),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*.1,),
                  Image.asset("images/logo.png",
                  height: MediaQuery.of(context).size.height*.2,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.025,),
                  Container(
                    height: MediaQuery.of(context).size.height*.57,
                    width: MediaQuery.of(context).size.width,
                    child:  new Swiper(
                      itemBuilder: (BuildContext context,int index){
                        return Column(children: [
                          new Center(
                            child:Image.asset(image[index],fit: BoxFit.fitHeight,height: MediaQuery.of(context).size.height*.3 ,) ,
                          ),

                             Container(
                              width:MediaQuery.of(context).size.width*.6 ,
                              padding: EdgeInsets.only(
                               top: MediaQuery.of(context).size.height*.05
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height*.028,),
                                  Text('${title[index]}',style: TextStyle(fontSize: 16,),textAlign: TextAlign.center,),
                                  SizedBox(height: 5,),
                                  Text('${subtitle[index]}',style:TextStyle(fontSize: 12,color: Colors.black38),textAlign: TextAlign.center,),
                                ],
                              ),


                          )
                        ],);


                      },
                      autoplay: true,
                      itemCount: image.length,
                      pagination: new SwiperPagination(
                        margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*.21 ),
                        builder: new DotSwiperPaginationBuilder(
                          color: Colors.grey, activeColor: Color(h.mainColor),
                        ),

                      ),
                      control: new SwiperControl(
                        color: Colors.white,
                      ),
                    ),

                  )

                ],
              ),
            ),
            GestureDetector(
              onTap: ()async{
                 appConfig.prefs.setString("chooselang", "first");
                 Navigator.of(context)
                     .pushNamedAndRemoveUntil(
                     '/mainPage'
                     //userType=="2"?"/DeleverMain":"/mainPage",
                     ,(Route<dynamic> route) => false);
              },
              child: Container(
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(h.mainColor)
                ),
                height: MediaQuery.of(context).size.height*.065,
                width: MediaQuery.of(context).size.width*.8,
                alignment: Alignment.center,
                child:CustomText.BtnText(DemoLocalizations.of(context).title['btn_skip']),

              ),
            ),

          ],
        ),
      ),
    );
  }

}


