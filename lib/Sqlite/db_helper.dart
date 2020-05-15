import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutternoop/Model/Order.dart';



class DatabaseHelper {
  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database
  static const String DB_NAME = 'foods.db';
  static const String TABLE = 'orderlist';
  static const String TABLE2 = 'orderlist2';
  static const String foodsID = 'foodsid';
  static const String foodsName = 'foodsname';
  static const String price = 'price';
  static const String size = 'size';
  static const String qty = 'qty';
  static const String description = 'description';
  static const String images = 'images';
  static const String totalPrice = 'totalprice';
  static const String taste = 'taste';
  static const String comment = 'comme';

  DatabaseHelper._createInstance();


  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + DB_NAME;

    // Open/create the database at a given path
    var todosDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }



  void _createDb(Database db, int newVersion) async {

    await db.execute(
        ' CREATE TABLE IF NOT EXISTS $TABLE($foodsID INTEGER PRIMARY KEY,$foodsName TEXT,$price REAL,$size TEXT,$description TEXT,$images TEXT,$qty INTEGER,$totalPrice REAL,$taste TEXT,$comment TEXT ) '
);

//    await db.execute(
//        ' CREATE TABLE IF NOT EXISTS $TABLE2($foodsID INTEGER PRIMARY KEY,$foodsName TEXT,$price REAL,$size TEXT,$description TEXT,$images TEXT,$qty INTEGER,$totalPrice REAL,$taste TEXT,$comment TEXT ) '
//    );

  }


  dropTable() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onDropTable);
    return _database;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute('ALTER TABLE orderlist ADD COLUMN taste TEXT;');
    }
  }

  _onDropTable(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS $TABLE');
  }


  Future<Order> save(Order order) async {
    print("===SAVE=====");
    var dbClient = await _database;
    order.foodsID = await dbClient.insert(TABLE, order.toMap());

    print(order);
    return order;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Order>> getOrders() async {
    var dbClient = await this.database;
    List<Map> maps = await dbClient.query(TABLE, columns: [
      foodsID,
      foodsName,
      price,
      size,
      qty,
      description,
      images,
      totalPrice,
      taste,
      comment,
    ]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Order> orders = [];

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        orders.add(Order.fromMap(maps[i]));
      }
    }
    return orders;
  }



  Future<List<Order>> getByID(int id) async {
    var dbClient = await this.database;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [
          foodsID,
          foodsName,
          price,
          size,
          qty,
          description,
          images,
          totalPrice,
          taste,
          comment
        ],
        where: '$foodsID = ?',
        whereArgs: [id]);
//   var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    List<Order> orders = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        orders.add(Order.fromMap(maps[i]));
      }
    }
    return orders;
  }

  Future<int> delete(int id) async {
    var dbClient = await this.database;
    return await dbClient.delete(TABLE, where: '$foodsID = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await this.database;
    return await dbClient.rawDelete("Delete from orderlist");
  }

  Future<int> updateBySQL({int foodsID}) async {
    var dbClient = await this.database;
    return await dbClient.rawDelete(
        "Update orderlist SET qty=qty+1,totalprice=(price*qty)+price where foodsid = " +
            foodsID.toString());
  }

  Future<int> removeQty(int id) async {
    var dbClient = await this.database;
    List<Map> maps = await dbClient.query(TABLE,
        columns: [
          foodsID,
          foodsName,
          price,
          size,
          qty,
          description,
          images,
          totalPrice,
          taste,
          comment
        ],
        where: '$foodsID = ?',
        whereArgs: [id]);
//   var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    List<Order> orders = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        orders.add(Order.fromMap(maps[i]));
      }
    }

    if (orders[0].qty == 1) {
      return await dbClient
          .delete(TABLE, where: '$foodsID = ?', whereArgs: [id]);
    } else {
      return await dbClient.rawUpdate(
          "Update orderlist SET qty=qty-1,totalprice=(price*qty)-price where foodsid = " +
              id.toString());
    }
  }

  Future<int> addQty(int id) async {
    var dbClient = await this.database;
    return await dbClient.rawUpdate(
        "Update orderlist SET qty=qty+1,totalprice=(price*qty)+price where foodsid = " +
            id.toString());
  }

  Future<double> calculateTotal() async {
    var dbClient = await this.database;
    var result = await dbClient.rawQuery("SELECT * FROM orderlist");
    List totalList;
    totalList = result.toList();
    double tot = 0;
    totalList.forEach((price) {
      tot = tot + price['totalprice'];
    });
    return tot;
    // return result.toList();
  }


  Future<String> getJsonOrder() async {
    var dbClient = await this.database;
    var result = await dbClient.rawQuery("SELECT * FROM orderlist");
    List totalList;
    totalList = result.toList();
    String json = '';
    int i = 0;
    totalList.forEach((price) {

      i += 1;

      json += '{"foodsID":"${price['foodsid']}",';
      json += '"foodsName":"${price['foodsname']}",';
      json += '"price":"${price['price']}",';
      json += '"size":"${price['size']}",';
      json += '"description":"${price['description']}",';
      json += '"qty":"${price['qty']}",';
      json += '"totalPrice":"${price['totalprice']}",';
      json += '"taste":"${price['taste']}",';
      if(i == totalList.length)
      {
        json += '"comment":"${price['comme']}"}';
      }
      else
      {
        json += '"comment":"${price['comme']}"},';
      }

    });
    print(json);
    return json;

  }

  Future<int> update(Order orders) async {
    var dbClient = await this.database;
    return await dbClient.update(TABLE, orders.toMap(),
        where: '$foodsID = ?', whereArgs: [orders.foodsID]);
  }

  Future close() async {
    var dbClient = await this.database;
    dbClient.close();
  }
}
