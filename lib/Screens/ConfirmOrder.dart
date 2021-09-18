import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Model/AddressModel.dart';
import 'package:mishwar/Screens/CustomAppBar.dart';
import 'package:mishwar/Screens/CustomText.dart';
import 'package:mishwar/Screens/EditProfile.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mishwar/app/Services/AddressServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
 import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'GlobalFunction.dart';
import 'AddAddress.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import 'SearchLocation.dart';
import '../main.dart';
import 'PaymentMethod.dart';

class ConfirmOrder extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<ConfirmOrder>{
  List<AddressModel>addressList;
  AddressServices addressServices=new AddressServices();
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    addressList=await addressServices.GetAddresses(prefs.getString("UserId"));
    setState(() {
    });
    print(addressList);
    print("4444444444444444");
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  home h=new home();
  String address ;
  String payment="payment2";
  bool ChooseAddress=false;
  TextEditingController message=new TextEditingController();
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
    // endDrawer: MyDrawer(-1),
     body: Directionality(
       textDirection: TextDirection.rtl,
       child: SingleChildScrollView(
         child: Column(
           children: [
             CustomAppBar(DemoLocalizations.of(context).title['followupwiththeorder']),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
               child: Column(
                 children: [
                /*   ClipRRect(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     child: Image.asset("images/map.png",
                     width: MediaQuery.of(context).size.width*.9,
                      height: MediaQuery.of(context).size.height*.2,
                       fit: BoxFit.fill,
                     ),
                   ),
                   SizedBox(height: MediaQuery.of(context).size.height*.02,),
                   GestureDetector(
                     onTap: (){
                       Navigator.push(context, GlobalFunction.route(SearchLocation()));
                     },
                     child: Container(
                       decoration:BoxDecoration(
                         borderRadius: BorderRadius.circular(10),color: Color(0xff0095ff),),
                       height: MediaQuery.of(context).size.height*.065,
                       width: MediaQuery.of(context).size.width*.9,
                       child:   Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ImageIcon(AssetImage("images/mapLocator.png"),size: 20,color: Colors.white,),
                           SizedBox(width: 15,),
                           Text("تحديد العنوان علي الخريطة",style: TextStyle(color:Colors.white,fontSize: 14,),),


                         ],
                       ),
                     ),
                   ),*/
                   SizedBox(height: MediaQuery.of(context).size.height*.02,),
                 ],
               ),
             ),
             Container(
               padding: EdgeInsets.only(
                 top: MediaQuery.of(context).size.height*.01,
                 bottom: MediaQuery.of(context).size.height*.01,
                 left: MediaQuery.of(context).size.width*.05,
                 right: MediaQuery.of(context).size.width*.05
               ),
               color: Colors.black12,
               alignment: Alignment.centerRight,
               child: Text("بيانات التوصيل"),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
               width: MediaQuery.of(context).size.width*.9,
               padding: EdgeInsets.only(
                 left: MediaQuery.of(context).size.width*.05,
                 right: MediaQuery.of(context).size.width*.05,
                 top: MediaQuery.of(context).size.height*.01,
                 bottom: MediaQuery.of(context).size.height*.01,
               ),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(5)),
                 color: Colors.black12.withOpacity(.05)
               ),
               child: Column(
                 children: [
                   GestureDetector(
                     onTap: (){
                       loadData();
                       setState(() {
                         ChooseAddress=!ChooseAddress;
                       });
                     },
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("اختر عنوانك"),
                         Icon(Icons.keyboard_arrow_down)
                       ],
                     ),
                   ),
                   ChooseAddress?addressList.length==0?
                   Container(
                       width: MediaQuery.of(context).size.width*.5,
                       height: MediaQuery.of(context).size.height*.15,
                       alignment: Alignment.center,
                       child: Text("لا يوجد عناوين خاصة بك قم باضافة عنوان ",
                         style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                         textAlign: TextAlign.center,))
                       :Container(
                     child: ListView.builder(
                       padding: EdgeInsets.only(
                         bottom: MediaQuery.of(context).size.height*.015
                       ),
                         itemCount: addressList.length,
                         shrinkWrap: true,
                         primary: false,
                         itemBuilder: (context,index){
                       return    GestureDetector(
                         onTap: (){
                           setState(() {
                             address = addressList[index].id;
                           });
                         },
                         child: Container(
                           height: MediaQuery.of(context).size.height*.085,
                           child: ListTile(
                             title:  Text(addressList[index].title,maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 12)),
                             subtitle: Text(addressList[index].address,maxLines: 1,style: TextStyle(color: Colors.black38,fontSize: 10),),
                             leading: Radio(
                               activeColor: Color(h.mainColor),
                               value: addressList[index].id,
                               groupValue: address,
                               onChanged: (String value) async {
                                 SharedPreferences prefs=await SharedPreferences.getInstance();
                                 prefs.setString("address_id", value);
                                 setState(() {
                                   address = value;
                                 });
                               },
                             ),
                           ),
                         ),
                       );
                     }),
                   ):SizedBox(),
                   ChooseAddress?  GestureDetector(
                     onTap: (){
                       setState(() {
                         ChooseAddress=!ChooseAddress;
                       });
                       Navigator.push(context, GlobalFunction.route(AddAddress("confirm")));
                     },
                     child: Container(
                       margin: EdgeInsets.only(
                           top: MediaQuery.of(context).size.height*.01,
                           bottom: MediaQuery.of(context).size.height*.01
                       ),
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
                                 color: Colors.white
                                 //  border: Border.all(width: 1.0,color: Colors.black26)
                               ),
                               child: Text("أضافة عنوان جديد",style: TextStyle(fontSize: 12),),
                             ),
                           )

                       ),
                     ),
                   ):SizedBox(),
                 ],
               ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
               padding: EdgeInsets.only(
                   top: MediaQuery.of(context).size.height*.01,
                   bottom: MediaQuery.of(context).size.height*.01,
                   left: MediaQuery.of(context).size.width*.05,
                   right: MediaQuery.of(context).size.width*.05
               ),
               color: Colors.black12,
               alignment: Alignment.centerRight,
               child: Text("طريقة الدفع"),
             ),
             //SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
               width: MediaQuery.of(context).size.width*.8,
               padding: EdgeInsets.only(
                 //left: MediaQuery.of(context).size.width
               ),
               child: Column(
                 children: [
                   GestureDetector(
                     onTap: (){
                     // Navigator.push(context, GlobalFunction.route(PaymentMethod()));
                       setState(() {
                         //payment = "payment1";
                       });
                     },
                     child: Container(
                       height: 30,
                      // color: Colors.red,
                       child: ListTile(
                         title:  Text("الدفع بالبطاقة الائتمانية",maxLines: 1,style: TextStyle(height: .7,color: Colors.black54,fontSize: 12)),
                         //subtitle: Text("المدينة المنطقة اسم الشارع رقم العمارة",maxLines: 1,style: TextStyle(color: Colors.black38,fontSize: 10),),
                         leading: Radio(
                           activeColor: Color(h.mainColor),
                           value: "payment1",
                           groupValue: payment,
                           onChanged: (String value) {
                             setState(() {
                             });
                           },
                         ),
                       ),
                     ),
                   ),
                   GestureDetector(
                     onTap: (){
                       // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                       setState(() {
                         payment = "payment2";
                       });
                     },
                     child: Container(
                       height: 30,
                       child: ListTile(
                         title:  Text("الدفع عند الاستلام",maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 12)),
                        // subtitle: Text("المدينة المنطقة اسم الشارع رقم العمارة",maxLines: 1,style: TextStyle(color: Colors.black38,fontSize: 10),),
                         leading: Radio(
                           activeColor: Color(h.mainColor),
                           value: "payment2",
                           groupValue: payment,
                           onChanged: (String value) {
                             setState(() {
                               payment = value;
                             });
                           },
                         ),
                       ),
                     ),
                   ),
                   SizedBox(height: 7,)
                 ],
               )
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
               padding: EdgeInsets.only(
                   top: MediaQuery.of(context).size.height*.01,
                   bottom: MediaQuery.of(context).size.height*.01,
                   left: MediaQuery.of(context).size.width*.05,
                   right: MediaQuery.of(context).size.width*.05
               ),
               color: Colors.black12,
               alignment: Alignment.centerRight,
               child: Text("ملاحظات اضافية"),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             Container(
               width: MediaQuery.of(context).size.width*.9,
               decoration: BoxDecoration(
                 borderRadius:BorderRadius.all(Radius.circular(10)),
               ),
               child: TextFormField(
                 onFieldSubmitted: (value){
                   FocusScope.of(context).requestFocus(FocusNode());
                 },
                 validator: (value){
                   if(value.isEmpty){
                     return 'ادخل الرسالة  ';
                   }
                   return null;
                 },
                 maxLines: 3,
                 minLines: 2,
                 decoration: InputDecoration(
                   errorStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(h.mainColor)),
                   hintStyle: TextStyle(fontSize: 10,color: Colors.black45),
                   contentPadding: EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10),
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
                   hintText: "اكـتب ملاحظاتك هنا لتسهيل عملية التوصيل",
                  // prefixIcon: Icon(Icons.https_rounded,size: 20,color: Colors.white,),
                 ),
                 controller: message,
               ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.02,),
             GestureDetector(
               onTap: (){
                 if(address!=null)
                 Navigator.pop(context);
                 else{
                   Toast.show(
                       "  اختر عنوان التوصيل  ", context,
                       duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                 }
               },
               child: Container(
                 decoration:BoxDecoration(
                   borderRadius: BorderRadius.circular(10),color: Color(0xff0095ff),),
                 height: MediaQuery.of(context).size.height*.065,
                 width: MediaQuery.of(context).size.width*.9,
                 alignment: Alignment.center,
                 child: Text("تـأكيد الطلب",style: TextStyle(color:Colors.white,fontSize: 14,),),
               ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.03,),
           ],
         ),
       ),
     ),
   ));
  }
}
class LabeledRadio extends StatelessWidget{
   LabeledRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });
  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;
  home h=new home();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged(value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              activeColor: Color(h.mainColor),
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}