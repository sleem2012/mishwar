class FavoriteModelLocal{
  //attributes = fields in table
  int _id;
  String _title;
  String _description;
  String _img;
  double _price;
  FavoriteModelLocal(dynamic obj){
    _id = obj['id'];
    _title = obj["title"];
    _description=obj["description"];
    _img=obj["img"];
    _price = obj["price"];
  }
  FavoriteModelLocal.fromMap(Map<String,dynamic> data){
    _id = data['id'];
    _title = data['title'];
    _description=data["description"];
    _img=data["img"];
    _price= data['price'];

  }
  Map<String, dynamic> toMap() => {'id' : _id,'title' : _title ,'description':_description,'img':_img,'price':_price};

  int get id => _id;
  String get title => _title;
  String get description=>_description;
  String get img=>_img;
  double get price => _price;

}