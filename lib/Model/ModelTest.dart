



class ResultOrderDetail {
  String ResultOk;
  String ErrorMessage;
  List<OrderDetail> orderList1;

  ResultOrderDetail(
      {this.ResultOk,
        this.ErrorMessage,
        this.orderList1
      });

  factory ResultOrderDetail.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['orderList'] as List;
    List<OrderDetail> orderDetailList =
    list.map((i) => OrderDetail.fromJson(i)).toList();

    return ResultOrderDetail(
        ResultOk: parsedJson['ResultOk'],
        ErrorMessage: parsedJson['ErrorMessage'],
        orderList1: orderDetailList);
  }
}

class OrderDetail {
  String orderID;
  String foodsID;
  String foodsName;
  String qty;
  String price;
  String totalPrice;
  OrderDetail({this.orderID, this.foodsID, this.foodsName, this.qty, this.price,this.totalPrice});

  factory OrderDetail.fromJson(Map<String, dynamic> parsedJson) {
    return OrderDetail(
      orderID: parsedJson['orderID'],
      foodsID: parsedJson['foodsID'],
      foodsName: parsedJson['foodsName'],
      qty: parsedJson['qty'],
      price: parsedJson['price'],
      totalPrice: parsedJson['totalPrice'],
    );
  }

}