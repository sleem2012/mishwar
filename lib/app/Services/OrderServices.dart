import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mishwar/Model/HomeDeliveryOrderModel.dart';
import 'package:mishwar/Model/OrderDeliveryModel.dart';
import 'package:mishwar/Model/OrderModel.dart';
import 'package:mishwar/Model/OrderStatusModel.dart';
 import 'GlobalVariables.dart';

class OrderServices{
  String baseURL=GlobalVariables.URL;
  Future<Map<String,dynamic>>MakeOrder(var body)async{
    String url=baseURL+"/Order/Create";
    try{
      final responce=await http.post(url,body:json.encode(body),headers:await getHeader());
      print(responce.body);
      print("000000000000000000000000000000000000000");
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
  Future<List<OrderStatusDetail>>GetOrderStatusUser()async
  {
    var url="${GlobalVariables.URL}/Order/UserStatuses";
    print(url);
    try
    {
      final response = await http.post(Uri.parse(url),headers:await getHeader());
      print(response.body);
      print("00000000000000000000000000");
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => OrderStatusDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<OrderStatusDetail>>GetOrderStatusDelevery()async
  {
    var url="${GlobalVariables.URL}/delivery/statuses";
    print(url);
    print( await getHeader());
    try
    {
      final response = await http.post(url,headers: await getHeader());
      print(response.body);
      print("00000000000000000000000000");
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => OrderStatusDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<OrderDetailModel>>GetOrders(var user_id,var status_id)async
  {
    var url="${GlobalVariables.URL}/Order/All?page=1";
    print(url);
    var body={
      "user_id":user_id,
      "status_id":status_id
    };
    print(body);
    try
    {
      final response = await http.post(Uri.parse(url),body: json.encode(body),headers: await getHeader());
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => OrderDetailModel.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<DeliveryOrderDetail>>GetOrdersDelivery(var user_id,var status_id)async
  {
    var url="${GlobalVariables.URL}/delivery/All?page=1";
    print(url);
    var body={
      "driver_id":user_id,
      "status_id":status_id
    };
    print(body);
    try
    {
      final response = await http.post(Uri.parse(url),body: json.encode(body),headers: await getHeader());
      print(response.body);
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => DeliveryOrderDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<List<HomeDeliveryOrderDetail>>GetDeliveryHome(var user_id)async
  {
    var url="${GlobalVariables.URL}/delivery/Home";
    print(url);
    var body={
      "driver_id":user_id
    };
    print('${body},,,,,,,,,,,,body main driver');
    try
    {
      final response = await http.post(Uri.parse(url),body: json.encode(body),headers: await getHeader());
      print(response.body);
      print("responceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => HomeDeliveryOrderDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
  Future<Map<String,dynamic>>EndOrder(var driver_id,var order_id)async{
    String url=baseURL+"/delivery/EndDelivery";
    print(url);
    var body={
      "driver_id":driver_id,
      "order_id":order_id
    };
    print(body);
    print("000000000000000000000000000000000000000000000000000000000000000");
    try{
      final responce=await http.post(url,body:json.encode(body),headers: await getHeader());
      print(responce.body);
      print("000000000000000000000000000000000000000");
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
  Future<Map<String,dynamic>>StartOrder(var driver_id,var order_id)async{
    String url=baseURL+"/delivery/StartDelivery";
    var body={
      "driver_id":driver_id,
      "order_id":order_id
    };
    try{
      final responce=await http.post(url,body:json.encode(body),headers: await getHeader());
      print(responce.body);
      print("000000000000000000000000000000000000000");
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
  Future<Map<String,dynamic>>CancelOrder(var driver_id,var order_id,var cancel_reason)async{
    String url=baseURL+"/delivery/CancelDelivery";
    print(url);
    var body={
      "driver_id":driver_id,
      "order_id":order_id,
      "cancel_reason":"Aaaaaaa"
    };
    print(body);

    try{
      final responce=await http.post(url,body:json.encode(body),headers: await getHeader());
      print(responce.body);
      print("000000000000000000000000000000000000000");
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
  Future<Map<String,dynamic>>CancelDeliveryAfterConfirm(var driver_id,var order_id,var cancel_reason)async{
    String url=baseURL+"/delivery/CancelDeliveryAfterConfirm";
    print(url);
    var body={
      "driver_id":driver_id,
      "order_id":order_id,
      "cancel_reason":"Aaaaaaa"
    };
    print(body);

    try{
      final responce=await http.post(url,body:json.encode(body),headers: await getHeader());
      print(responce.body);
      print("000000000000000000000000000000000000000");
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