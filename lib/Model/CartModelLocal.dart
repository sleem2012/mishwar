class CartMedelLocal{
  //attributes = fields in table
  int _id;
  String _name;
  String _img;
  String _description;
  double _price;
  double _price2;
  double _totalPrice;
  int _quantity;
  CartMedelLocal(dynamic obj) {
    _id = obj['id'];
    _name = obj["name"];
    _img = obj["img"];
    _price = obj["price"];
    _price2 = obj["price2"];
    _totalPrice = obj["totalPrice"];
    _quantity = obj["quantity"];
    _description = obj["description"];
  }
    CartMedelLocal.fromMap(Map < String, dynamic > data){
       _id=data['id'];
      _name = data['name'];
      _img = data['img'];
      _description = data["description"];
      _price = data['price'];
      _price2 = data["price2"];
      _totalPrice = data['totalPrice'];
      _quantity = data['quantity'];
    }
    Map<String, dynamic> toMap() =>
        {
          'id': _id,
          'name': _name,
          'img': _img,
          "description": _description,
          'price': _price,
          "price2": _price2,
          'totalPrice': _totalPrice,
          'quantity': _quantity
        };

    int get id =>
    _id;
    String get name =>
    _name;
    String get img =>
    _img;
    String get description =>
    _description;
    double get price =>
    _price;
    double get price2 =>
    _price2;
    double get totalPrice =>
    _totalPrice;
    int get quantity =>
    _quantity;
  }