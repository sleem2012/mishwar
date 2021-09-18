import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Model/BranchModel.dart';
import 'package:mishwar/app/Services/ConfigServices.dart';
 import 'GlobalFunction.dart';
import 'BranchDetail.dart';
import 'package:mishwar/lang/app_Localization.dart';



class Branches extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _state();
  }
}
class _state extends State<Branches>{
  List<BranchModelDetail>Branches=[];
  ConfigServices configServices=new ConfigServices();
  loadData()async{
    Branches=await configServices.GetBranches();
    setState(() {
    });
    print('${Branches.length},,,,length,,,branches');
   // print('${Branches.toString()},,,,branches');
    print("ssssssssssss");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
  return
              Branches.length==0?  Center(child: CircularProgressIndicator(),):
               ListView.builder(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height*.03
                ),
                  itemCount: Branches.length,itemBuilder: (context,index){
                print('${Branches[index].address.toString()},,،address,,branche');

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, GlobalFunction.route(BrachDetail(Branches[index])));
                  },
                  child:   Container(
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.03,
                      right:  MediaQuery.of(context).size.width*.05,
                      left:  MediaQuery.of(context).size.width*.05,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black12.withOpacity(.08),width: 1),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.03),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ), child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ClipRRect(
                           borderRadius: BorderRadius.only(
                           topRight: Radius.circular(10),topLeft: Radius.circular(10)
                           ),
                            child:FadeInImage.assetNetwork(
                              placeholder: "images/Spinner.gif",
                              image:Branches[index].image==null?"":Branches[index].image,
                              height: MediaQuery.of(context).size.height*.15,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width*.02,
                              top: MediaQuery.of(context).size.height*.01,
                              // bottom: MediaQuery.of(context).size.height*.01,
                              left: MediaQuery.of(context).size.width*.02,
                            ),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                  Text(Branches[index].name,style: TextStyle(height: .8,fontSize: 14,color: Colors.black54),),
                                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,size: 17,color: Colors.black45,),
                                      SizedBox(width: 3,),
                                      Container(
                                          width: MediaQuery.of(context).size.width*.75,
                                          child: Text(Branches[index].address==null?"":Branches[index].address.toString(),
                                            maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 11),))
                                    ],
                                  ),
                                    /*Row(
                                      children: [
                                        Icon(Icons.person,size: 17,color: Colors.black45,),
                                        SizedBox(width: 3,),
                                        Container(
                                            width: MediaQuery.of(context).size.width*.7,
                                            child: Text("اسم المستخدم",maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 12),))
                                      ],
                                    ),*/
                                    Row(
                                      children: [
                                        Icon(Icons.phone,size: 17,color: Colors.black45,),
                                        SizedBox(width: 3,),
                                        Container(
                                            //width: MediaQuery.of(context).size.width*.7,
                                            child: Text(Branches[index].phone==null?"":Branches[index].phone,textDirection: TextDirection.ltr,maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 11),))
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                ],),
                                DemoLocalizations.of(context)
                                    .locale  == Locale("ar")
                                    ? Icon(Icons.arrow_back_ios_rounded, size: 15, color: Colors.black45)
                                    : Icon(Icons.arrow_forward_ios_rounded,
                                    size: 15, color: Colors.black45),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })


  ;
  }
}