import 'package:mishwar/Model/CategoryModel.dart';
import 'package:mishwar/Model/ProductModel.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/app/AppConfig.dart';

part 'app.data.controller.g.dart';

class DApp = _DApp with _$DApp;

abstract class _DApp with Store {
  @observable
  bool loadCategory = false;
  @observable
  bool loadProducts = false;
  @observable
  String selectedCategory;

  @observable
  ObservableList<CategoryDetail> mainCategoryList = ObservableList();
  @observable
  ObservableList<ProductDetail> mainProductsList = ObservableList();

  @action
  setSelectedCategory(CategoryDetail categoryDetail) =>
      selectedCategory = categoryDetail.id.toString();

  @action
  mainCategoryListFetch(List<CategoryDetail> value) {
    mainCategoryList
      ..clear()
      ..addAll(value);
    loadCategory=true;
    // print('${mainCategoryList.length},,,,,,,,,,,,fds');
  }

  @action
  mainProductsListFetch(List<ProductDetail> value) {
    mainProductsList
      ..clear()
      ..addAll(value);
    loadProducts=true;
    // print('${mainCategoryList.length},,,,,,,,,,,,fds');
  }
}
