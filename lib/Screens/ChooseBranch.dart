import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'GlobalFunction.dart';
import 'HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class ChooseBranch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<ChooseBranch>{
  home h=new home();
  List branches=["فرع العباسية","فرع جسر السويس","فرع الدقي","فرع فيصل","فرع الهرم","فرع مصر الجديده","فرع المهندسين","فرع مدينة نصر","فرع رابعة","فرع اول مكرم","فرع اول عباس","فرع المنيب"];
 String SelectedBranch;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          SizedBox(height: MediaQuery.of(context).size.height*.175),
           Container(
             padding: EdgeInsets.only(
               left: MediaQuery.of(context).size.width*.15,
               right: MediaQuery.of(context).size.width*.15,
             ),
             child: Image.asset("images/logo.png",
               height: MediaQuery.of(context).size.height*.2,
               fit: BoxFit.cover,
             ),
           ),
           SizedBox(height: MediaQuery.of(context).size.height*.035),
           Container(
             width: MediaQuery.of(context).size.width*.8,
             height: 1,
             color: Colors.black12,
           ),
           SizedBox(height: MediaQuery.of(context).size.height*.025),
           Text("اختر الفرع",style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.bold),),
           SizedBox(height: MediaQuery.of(context).size.height*.02),
           GestureDetector(
             onTap: (){
               SelectedBranches(context);
             },
             child: Container(
               width: MediaQuery.of(context).size.width*.8,
               height: MediaQuery.of(context).size.height*.065,
               margin: EdgeInsets.only(
                 left: MediaQuery.of(context).size.width*.05,
                 right: MediaQuery.of(context).size.width*.05
               ),
               padding: EdgeInsets.only(
                   left: MediaQuery.of(context).size.width*.04,
                   right: MediaQuery.of(context).size.width*.05
               ),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(10)),
                 border: Border.all(color: Colors.black12,width: 1),
                 color: Colors.white
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [

                   Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black54),
                   Text(SelectedBranch==null?"اختر الفرع":SelectedBranch,style: TextStyle(color: Colors.black54),),
                 ],
               ),
             ),
           ),
           SizedBox(height: MediaQuery.of(context).size.height*.02),
           GestureDetector(
             onTap: ()async{
              if(SelectedBranch!=null)
           {
             SharedPreferences prefs=await SharedPreferences.getInstance();
             prefs.setString("branch_id", "1");
             Navigator.push(context, GlobalFunction.routeBottom(HomePage()));
           }
              else{
                Toast.show(
                    "من فضلك اختر الفرع الاقرب لك", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              }
             },
             child: Container(
               width: MediaQuery.of(context).size.width*.8,
                 height: MediaQuery.of(context).size.height*.065,
                 margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.005,top: MediaQuery.of(context).size.height*.005),
                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.005,top: MediaQuery.of(context).size.height*.005),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     color: Color(h.mainColor)
                 ),
                 alignment: Alignment.center,
                 child: Text("تأكيد",style: TextStyle(color: Colors.white),)),
           )
         ],
       ),
     ),
   );
  }
  SelectedBranches(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            width: MediaQuery.of(context).size.width*.4,
            decoration: BoxDecoration(color: Colors.white,
              // borderRadius: BorderRadius.all(Radius.circular(20))
              // border: Border.all(color: Colors.black12,width: 2.0)
            )
            ,padding: EdgeInsets.only(
            top:  MediaQuery.of(context).size.height*0.01,
            bottom: MediaQuery.of(context).size.height*0.01,
            left: MediaQuery.of(context).size.width*0.05,
            right: MediaQuery.of(context).size.width*0.05,
          ),


            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: branches.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            SelectedBranch=branches[index];
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.005,top: MediaQuery.of(context).size.height*.005),
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.005,top: MediaQuery.of(context).size.height*.005),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Color(h.blueColor)
                            ),
                            alignment: Alignment.center,
                            child: Text(branches[index],style: TextStyle(color: Colors.white),)),
                      );
                    },
                  ),
                ],
              ),
            ),

          ),
        ));
  }
}