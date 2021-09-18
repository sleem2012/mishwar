import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Model/CartModelLocal.dart';
import 'Model/FavouriteLocalModel.dart';

class DbHelper{
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database _db;
  Future<Database> createDatabase() async{
    if(_db != null){
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'cart.db');
    _db = await openDatabase(path,version: 1, onCreate: (Database db, int v){
      //create tables
      db.execute("CREATE TABLE product ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "img TEXT,"
          "description TEXT,"
          "price REAL,"
          "price2 REAL,"
          "totalPrice REAL,"
          "quantity INTEGER"
          ")");
      db.execute("CREATE TABLE favorite ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "img TEXT,"
          "price REAL"

          ")");

    });
    return _db;
  }
  Future<int> addToCart(CartMedelLocal cartMedelLocal ) async{
    Database db = await createDatabase();
    //db.rawInsert('insert into courses value')
    return db.insert('product', cartMedelLocal.toMap());
  }
  Future<List> allProduct() async{
    Database db = await createDatabase();
    //db.rawQuery('select * from courses');
    return db.query('product');
  }

  Future<int> delete(int id) async{
    Database db = await createDatabase();
    return db.delete('product', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> deleteCart() async{
    Database db = await createDatabase();
    return db.delete('product');
  }
  Future<int> updateCourse(CartMedelLocal product) async{
    Database db = await createDatabase();
    var x=await db.update('product', product.toMap(),where: 'id = ?', whereArgs: [product.id]);
    return x;
  }
  /////////////////////////////////
  Future<int> addToFavorite(FavoriteModelLocal favoriteModelLocal ) async{
    Database db = await createDatabase();
    //db.rawInsert('insert into courses value')
    return db.insert('favorite', favoriteModelLocal.toMap());
  }
  Future<List> allFavorite() async{
    Database db = await createDatabase();
    //db.rawQuery('select * from courses');
    return db.query('favorite');
  }
  Future<int> deleteFavorite(int id) async{
    Database db = await createDatabase();
    return db.delete('favorite', where: 'id = ?', whereArgs: [id]);
  }
  Future<int> updateFavorite(FavoriteModelLocal favoriteModelLocal) async{
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    Database db = await createDatabase();
    return await db.update('favorite', favoriteModelLocal.toMap(),where: 'id = ?', whereArgs: [favoriteModelLocal.id]);
  }
  Future<bool> isProductFoundInFavouriteTable(int id) async {
    Database db = await createDatabase();
    List<Map> productList = await db
        .rawQuery('SELECT * FROM favorite where id = ?', [id]);
    if (productList.length > 0) {
      return true;
    }
    return false;
  }
}