import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/main.dart';

import 'CustomAppBar.dart';

class Offers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
 return _state();
  }
}
class _state extends State<Offers>{
  home h=new home();
  List <String>images=["images/food.png","images/product1.png","images/product2.png","images/product3.png","images/product4.png",
    "images/product5.png","images/product6.png","images/cart.png"];
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: (){
       Navigator.pushNamedAndRemoveUntil(context, "/mainPage", (route) => false);
     },
     child: Expanded(
       child:  GridView.builder(
         padding: EdgeInsets.only(
           top:MediaQuery.of(context).size.height*.02,
             left: MediaQuery.of(context).size.width*.05,
             right: MediaQuery.of(context).size.width*.05,
           bottom: MediaQuery.of(context).size.height*.03,
         ),
         primary: false,
         shrinkWrap: true,
         itemCount: images.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2,
             mainAxisSpacing: MediaQuery.of(context).size.width*.05,
             crossAxisSpacing: MediaQuery.of(context).size.width*.05,
             childAspectRatio: 1/1.05
         ),
         itemBuilder: (context,index){
           return Container(
             child: Stack(
               children: [
                 Container(
                   height: MediaQuery.of(context).size.height*.25,
                   child: ClipRRect(
                     borderRadius: BorderRadius.only(
                         topRight: Radius.circular(5),
                         topLeft: Radius.circular(5),
                       bottomRight: Radius.circular(5),
                       bottomLeft: Radius.circular(5),
                     ),
                     child: Image.asset("images/food.png",
                       fit: BoxFit.cover,
                     ),
                   ),
                 ),
                 Positioned(
                   child: Container(
                     //  width: MediaQuery.of(context).size.width*.4,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                             padding: EdgeInsets.all(5),
                             child: Icon(Icons.bookmark_border,size: 0,color: Colors.white,)),
                         Container(
                             width: 50,
                             height: 40,
                             decoration: BoxDecoration(
                                 color: Color(h.mainColor),
                                 borderRadius: BorderRadius.only(
                                     topRight: Radius.circular(5),
                                     topLeft: Radius.circular(10),
                                     bottomRight: Radius.circular(100),
                                     bottomLeft: Radius.circular(5)
                                 )
                             ),
                             //padding: EdgeInsets.all(10),
                             alignment: Alignment.center,
                             child: Text("75 %",style: TextStyle(color: Colors.white,fontSize: 12),)),

                       ],
                     ),
                   ),
                 )
               ],
             )
                ,
              /*   Container(
                  // width:MediaQuery.of(context).size.width*.4,
                   color: Colors.white,
                   padding: EdgeInsets.only(
                       left: 4,
                       right: 4
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(height: 5,),
                             Text("وجبة جديدة",style: TextStyle(height: 1.2,fontSize: 12,fontWeight: FontWeight.bold,color: Color(h.mainColor))),
                             Text("سطر واحد وصف للوجية",style: TextStyle(height: 1.2,fontSize: 10,color: Colors.black54),maxLines: 1,)
                             , SizedBox(height: 5,),
                           ],
                         ),
                       ),
                       GestureDetector(
                         onTap: (){
                         },
                         child: Container(
                           padding: EdgeInsets.all(2),
                           child: Container(
                             width: 20,
                             height: 20,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(100)),
                                 color: Color(h.mainColor)
                             ),
                             child: Icon(Icons.add,size: 19,color: Colors.white,),
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
                 Container(
                   decoration:BoxDecoration(
                     borderRadius: BorderRadius.only(
                       bottomRight: Radius.circular(5),
                       bottomLeft: Radius.circular(5),
                     ),color: Color(h.blueColor),),
                   height: MediaQuery.of(context).size.height*.042,
                   width: MediaQuery.of(context).size.width,
                   alignment: Alignment.center,
                   child:    Text("العرض لمدة 24 ساعة",style: TextStyle(color:Colors.white,fontSize: 10),),

                 ),*/


           );
         },
       )
     ),
   );
     /*Expanded(
     child: Container(
       margin: EdgeInsets.zero,
       color: Colors.white,
       width: MediaQuery.of(context).size.width,
       padding: EdgeInsets.only(
         right: MediaQuery.of(context).size.width*.03,
         left: MediaQuery.of(context).size.width*.03,
       ),

       child:  images.length>0?GridView.builder(
         primary: false,
         padding: EdgeInsets.only(bottom: 50),
         shrinkWrap: true,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2,
             mainAxisSpacing: 10,
             crossAxisSpacing: 10,
             childAspectRatio: 1/1
         ),
         itemBuilder: (context,index){
           return ClipRRect(
             borderRadius: BorderRadius.all(Radius.circular(10)),
             child: InkWell(
                 child:Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(15)),
                       border: Border.all(color: Color(h.mainColor),width: 2)
                   ),
                   child: ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     child: Image.asset(images[index],
                       fit: BoxFit.cover,
                     ),
                   ),
                 ),
                 onTap: (){
                 }


             ),
           );
         },
         itemCount:images.length,

       ):Center(child: CircularProgressIndicator(),),
     ),
   )*/;
  }
}