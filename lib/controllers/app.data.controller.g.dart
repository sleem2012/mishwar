// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.data.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DApp on _DApp, Store {
  final _$loadCategoryAtom = Atom(name: '_DApp.loadCategory');

  @override
  bool get loadCategory {
    _$loadCategoryAtom.reportRead();
    return super.loadCategory;
  }

  @override
  set loadCategory(bool value) {
    _$loadCategoryAtom.reportWrite(value, super.loadCategory, () {
      super.loadCategory = value;
    });
  }

  final _$loadProductsAtom = Atom(name: '_DApp.loadProducts');

  @override
  bool get loadProducts {
    _$loadProductsAtom.reportRead();
    return super.loadProducts;
  }

  @override
  set loadProducts(bool value) {
    _$loadProductsAtom.reportWrite(value, super.loadProducts, () {
      super.loadProducts = value;
    });
  }

  final _$selectedCategoryAtom = Atom(name: '_DApp.selectedCategory');

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  final _$mainCategoryListAtom = Atom(name: '_DApp.mainCategoryList');

  @override
  ObservableList<CategoryDetail> get mainCategoryList {
    _$mainCategoryListAtom.reportRead();
    return super.mainCategoryList;
  }

  @override
  set mainCategoryList(ObservableList<CategoryDetail> value) {
    _$mainCategoryListAtom.reportWrite(value, super.mainCategoryList, () {
      super.mainCategoryList = value;
    });
  }

  final _$mainProductsListAtom = Atom(name: '_DApp.mainProductsList');

  @override
  ObservableList<ProductDetail> get mainProductsList {
    _$mainProductsListAtom.reportRead();
    return super.mainProductsList;
  }

  @override
  set mainProductsList(ObservableList<ProductDetail> value) {
    _$mainProductsListAtom.reportWrite(value, super.mainProductsList, () {
      super.mainProductsList = value;
    });
  }

  final _$_DAppActionController = ActionController(name: '_DApp');

  @override
  dynamic setSelectedCategory(CategoryDetail categoryDetail) {
    final _$actionInfo =
        _$_DAppActionController.startAction(name: '_DApp.setSelectedCategory');
    try {
      return super.setSelectedCategory(categoryDetail);
    } finally {
      _$_DAppActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic mainCategoryListFetch(List<CategoryDetail> value) {
    final _$actionInfo = _$_DAppActionController.startAction(
        name: '_DApp.mainCategoryListFetch');
    try {
      return super.mainCategoryListFetch(value);
    } finally {
      _$_DAppActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic mainProductsListFetch(List<ProductDetail> value) {
    final _$actionInfo = _$_DAppActionController.startAction(
        name: '_DApp.mainProductsListFetch');
    try {
      return super.mainProductsListFetch(value);
    } finally {
      _$_DAppActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadCategory: ${loadCategory},
loadProducts: ${loadProducts},
selectedCategory: ${selectedCategory},
mainCategoryList: ${mainCategoryList},
mainProductsList: ${mainProductsList}
    ''';
  }
}
