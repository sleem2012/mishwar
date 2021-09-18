import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mishwar/Model/BranchModel.dart';
import 'package:mishwar/Screens/BranchDetail.dart';

import 'GlobalVariables.dart';

class ConfigServices{
  String baseURL=GlobalVariables.URL;
  Future<Map<String,dynamic>>GetPolicyServices()async{
    String url=baseURL+"/config/GetPolicy";
    try{
      final responce=await http.post(url,headers: await getHeader());
      if(responce.body.isNotEmpty)
      {
        print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<Map<String,dynamic>>GetTermsServices()async{
    String url=baseURL+"/config/GetTerms";
    print(url);
    try{
      final responce=await http.post(url,headers: await getHeader());
      print(responce.body);
      if(responce.body.isNotEmpty)
      {
        print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<Map<String,dynamic>>AboutAppServices()async{
    String url=baseURL+"/config/GetAboutUs";
    try{
      final responce=await http.post(url,headers: await getHeader());
      if(responce.body.isNotEmpty)
      {
        return json.decode(responce.body);
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<Map<String,dynamic>>ContactUsServices(var name,var phone,var email,var message)async{
    String url=baseURL+"/config/ContactUs";
    var body= {
      "name":name,
      "phone":phone,
      "email":email,
      "message":message
    };
    try{
      final responce=await http.post(url,body: json.encode(body),headers: await getHeader());
      if(responce.body.isNotEmpty)
      {
        print(responce.body);
        return json.decode(responce.body);
      }

    }
    catch(e) {
      print(e.toString());
    }
  }
  Future<List<BranchModelDetail>>GetBranches()async
  {
    var url="${GlobalVariables.URL}/config/AllBranches";
    try
    {
      final response = await http.post(Uri.parse(url),headers: await getHeader());
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => BranchModelDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
}