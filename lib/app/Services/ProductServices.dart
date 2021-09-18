import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mishwar/Model/CategoryModel.dart';
import 'package:mishwar/Model/ProductModel.dart';
import 'package:mishwar/Model/SubProductModel.dart';
import 'GlobalVariables.dart';
import 'package:mishwar/app/AppConfig.dart';

class ProductServices {
   getCategory()async
  {
    var url="${GlobalVariables.URL}/food/AllCategories";
    try
    {
      final response = await http.post(Uri.parse(url),headers:await getHeader());
      if(response.statusCode==200 && response.body!=null)
      {
        List sliderItems = json.decode(appConfig.cApp.appLocale.toString()=="ar"?utf8.decode(response.bodyBytes):response.body)["Message"];
        appConfig.dApp.mainCategoryListFetch(sliderItems.map((e) => CategoryDetail.fromJson(e)).toList());
        appConfig.dApp.setSelectedCategory(appConfig.dApp.mainCategoryList[0]);
       // print('heeeeeeeeeeeeee');
       }
    }
    catch(e)
    {
      print('$e,,,,error main Products');
    }
  }
  getProduct(var id,var page)async
  {
    var url="${GlobalVariables.URL}/food/AllItems?page=$page";
    var body={
      "category_id":id
    };
    print('${body},,daadad');//appConfig.dApp
    print('${appConfig.dApp.selectedCategory},,selectedCategory');
    try
    {
       final response = await http.post(Uri.parse(url),body: json.encode(body),headers:await  getHeader());
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(appConfig.cApp.appLocale.toString()=="ar"?
        utf8.decode(response.bodyBytes):response.body)["Message"];
        appConfig.dApp.mainProductsListFetch(slideritems.map((e) => ProductDetail.fromJson(e)).toList());
      //  return slideritems.map((e) => ProductDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error main products');
    }
  }
  Future<List<SubProductDetail>>GetSubProduct(var id)async
  {
    var url="${GlobalVariables.URL}/food/GetSubItems";
    print(url);
    var body={
      "product_id":id
    };
    print(body);
    try
    {
      final response = await http.post(Uri.parse(url),body: json.encode(body),headers:await getHeader());
      print(response.body);
      print("000000000000000");
      if(response.statusCode==200 && response.body!=null)
      {
        List slideritems = json.decode(utf8.decode(response.bodyBytes))["Message"];
        return slideritems.map((e) => SubProductDetail.fromJson(e)).toList();
      }
    }
    catch(e)
    {
      print('$e,,,,error search doctors');
    }
  }
}
ProductServices productServices=ProductServices();