import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mishwar/Model/AddressModel.dart';
import 'package:mishwar/Model/RegionModel.dart';
 import 'GlobalVariables.dart';

class AddressServices{
  String baseURL=GlobalVariables.URL;
  Future<List<RegionDetail>>GetRegions()async
  {
    var url="${GlobalVariables.URL}/address/Regions";
    try
    {
      final response = await http.post(Uri.parse(url),headers: await getHeader());
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => RegionDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>addAddressService(var user_id,var title,var address,var mark,var lat,var lng,phone,var phone2,var region_id)async{
    String url=baseURL+"/address/Add";
    var body={
      "user_id":user_id,
      "title":title,
      "address":address,
      "land_mark":mark,
      "lat":lat,
      "lng":lng,
      "phone1":phone,
      "phone2":phone2,
      "region_id":region_id
    };
    print(body);
    print("pppppppppppppppppppppppppppp");
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
  Future<List<AddressModel>>GetAddresses(var user_id)async
  {
    var url="${GlobalVariables.URL}/address/All";
    var body={
      "user_id":user_id
    };
    print('${body},,,,,,,,,bodyaddresss');
    try
    {
      final response = await http.post(Uri.parse(url),body: json.encode(body),headers: await getHeader());
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => AddressModel.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>SetPrimaryAddress(var id)async{
    String url=baseURL+"/address/SetPrimary";
    var body={
      "address_id":id
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
  Future<Map<String,dynamic>>deleteAddress(var id)async{
    String url=baseURL+"/address/Delete";
    var body={
      "address_id":id
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
}