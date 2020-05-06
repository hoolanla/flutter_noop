class Menu{
  String ResultOk;
  String ErrorMessage;
  String CountMenu;
  List<Data> data;

  Menu  ({this.ResultOk,
    this.ErrorMessage,
    this.CountMenu,
    this.data});

  factory Menu.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['Data'] as List;
    List<Data> data = list.map((i) => Data.fromJson(i)).toList();

    return Menu(
        ResultOk: parsedJson['ResultOk'],
        ErrorMessage: parsedJson['ErrorMessage'],
        CountMenu: parsedJson['CountMenu'],
        data: data

    );
  }
}

class Data{
  String foodsTypeIDLevel1;
  String foodsTypeIDLevel2;
  String foodsTypeNameLevel1;
  String foodsTypeNameLevel2;
  List<foodsItem> foodsItems;

  Data({
    this.foodsTypeIDLevel1,
    this.foodsTypeIDLevel2,
    this.foodsTypeNameLevel1,
    this.foodsTypeNameLevel2,
    this.foodsItems
  });

  factory  Data.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['foodsItems'] as List;
    List<foodsItem> foods = list.map((i) => foodsItem.fromJson(i)).toList();

    return Data(
        foodsTypeIDLevel1: parsedJson['foodsTypeIDLevel1'],
        foodsTypeIDLevel2: parsedJson['foodsTypeIDLevel2'],
        foodsTypeNameLevel1: parsedJson['foodsTypeNameLevel1'],
        foodsTypeNameLevel2: parsedJson['foodsTypeNameLevel2'],
        foodsItems: foods

    );
  }
}

class foodsItem{
  int foodID;
  String foodName;
  double price;
  String size;
  String description;
  String images;



  foodsItem({
    this.foodID,
    this.foodName,
    this.price,
    this.size,
    this.description,
    this.images,
  });

  factory foodsItem.fromJson(Map<String, dynamic> parsedJson){
    return foodsItem(
      foodID: int.parse(parsedJson['foodsID']),
      foodName : parsedJson['foodsName'],
      price: parsedJson['price'],
      size : parsedJson['size'],
      description: parsedJson['description'],
      images : parsedJson['images'],

    );
  }

}
//
//class detailFood{
//  int foodID;
//  String foodName;
//  double price;
//  double priceS;
//  double priceM;
//  double priceL;
//  String size;
//  String description;
//  String images;
//
//
//  detailFood(
//      this.foodID,
//      this.foodName,
//      this.price,
//      this.priceS,
//      this.priceM,
//      this.priceL,
//      this.size,
//      this.description,
//      this.images
//      );
//}

