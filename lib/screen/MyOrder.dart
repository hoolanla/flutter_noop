
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternoop/Model/Order.dart';
import 'dart:async';
import 'package:flutternoop/Sqlite/db_helper.dart';


//String _restaurantID = globals.restaurantID;
//String _tableID = globals.tableID;
//String _userID = globals.userID;

Future<List<Order>> orders;
Future<StatusOrder> statusOrders;
List<Order> _order;
Future<double> _totals;
Future<double> _totalsCheckbill;
Future<String> _jsonBody;
String jsonBody;



int foodsID;
String foodsName;
double price;
String size;
String description;
String images;
int qty;
String taste;

String iTest = '';

void main() {
  runApp(MyOrder());
}

class MyOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShowData();
  }
}

class _ShowData extends State<MyOrder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<List<Order>> orders;
  int foodID;

  String foodsName;
  double price;
  double priceS;
  double priceM;
  double priceL;
  String size;
  String description;
  String images;
  int qty;
  double totalPrice;
  String taste;
  String comment = '';

  List<Order> HaveData;
  String open_time;
  String close_time;


//  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    refreshList();
    refreshTotal();
    refreshJsonBody();
  }


  refreshList() {
    setState(() {
      orders = dbHelper.getOrders();
    });
  }

  refreshTotal() {
    setState(() {
      _totals = dbHelper.calculateTotal();
    });
  }

  refreshJsonBody() {
    setState(() {
      _jsonBody = dbHelper.getJsonOrder();
    });
  }

  void _removeQty({int foodsID}) async {
    int i;
    i = await dbHelper.removeQty(foodsID);

    refreshTotal();
    refreshList();
    refreshJsonBody();
  }

  void _addQty({int foodsID}) async {
    int i;
    i = await dbHelper.addQty(foodsID);
    refreshTotal();
    refreshList();
    refreshJsonBody();
  }

  //CODE HERE

  void _showAlertDialog2({String strError}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(strError),
            content: Text(""),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyOrder()),
                  );
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  Widget HeaderColumn() {
    return new Container(
      height: 30,
      child: new ListTile(
        onTap: null,
        title: Row(children: <Widget>[
          new Expanded(
              child: new Text(
                "รายการ",
                style: TextStyle(
                  fontFamily: 'Kanit',
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ]),
      ),
    );
  }

  Widget _noOrder() {

    return new Card(
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Image.asset('assets/images/empty-cart.gif'),
      ),
    );
  }

  headerListOrder() {
    return Text(
      'Sqlite',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'Kanit',
      ),
    );
  }

  /// CODE1

  list() {
    return Expanded(
      child: FutureBuilder(
        future: orders,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              if (snapshot.data.length == 0) {
                return _noOrder();
              } else {
                return new Container(
                  child: _ListSection(orders: snapshot.data),
                );
              }
            } else {
              //   return _noOrder();
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        height: 10.0,
                        width: 10.0,
                      )
                    ],
                  ),
                ),
              );
            }
            //   _order = snapshot.data;
          } else {
            //  return _noOrder();
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      height: 10.0,
                      width: 10.0,
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _ListSection({List<Order> orders}) => ListView.builder(
    itemCount: orders.length,
    itemBuilder: (context, int idx) {
      if (orders.length == 0) {
        return Padding(
          padding: EdgeInsets.all(2.0),
          child: Image.asset('assets/images/empty-cart.gif'),
        );
      } else {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Container(
            child: ListTile(

              title: new Text(
                orders[idx].foodsName.toString(),
                style: TextStyle(
                  fontFamily: 'Kanit',
                ),
              ),
              subtitle: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          'ราคา: ',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          orders[idx].price.toString().replaceAll('.0', ''),
                          style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                        child: Text(
                          'รวม: ',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          orders[idx].totalPrice.toString().replaceAll('.0', ''),
                          style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeQty(
                                    foodsID: orders[idx].foodsID)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              orders[idx].qty.toString(),
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Kanit',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                ),
                                onPressed: () =>
                                    _addQty(foodsID: orders[idx].foodsID)),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              trailing: null,
            ),
            decoration: new BoxDecoration(
                border: Border(
                    bottom: new BorderSide(
                      color: Colors.cyan,
                      width: 0.5,
                      style: BorderStyle.solid,
                    ))),
          ),
        );
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontFamily: 'Kanit',
          ),
        ),
        backgroundColor: Colors.cyan,
        title: new Text(
          'Sqlite',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 20.0,
            fontFamily: 'Kanit',
          ),
        ),
      ),
      body: new  Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[

            list(),
            Row(children: <Widget>[
              Expanded(
                child: new RaisedButton(
                  color: Colors.white,
                  child: FutureBuilder(
                      future: _totals,
                      builder: (context, snapshot) {
                        return Text(
                          'รวมราคา  ${snapshot.data.toString().replaceAll('.0', '')}  บาท',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Kanit',
                          ),
                        );
                      }),
                  onPressed: () {

                  },
                ),
              ),
              SizedBox(width: 4,),
              Expanded(
                child: new RaisedButton(
                  color: Colors.pinkAccent,
                  child: FutureBuilder(
                      future: _jsonBody,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          jsonBody = snapshot.data;
                        }
                        return Text(
                          'Add Data ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Kanit',
                          ),
                        );
                      }),
                  onPressed: () {
_foo();
                  },
                ),
              ),
              SizedBox(width: 4,),
            ])
          ],
        ),
      ),

    );
  }


  void _foo() async {
    foodID = int.parse('3');
    HaveData = await dbHelper.getByID(foodID);

    if (HaveData.length == 0) {
      foodsName = 'กระเพราหมู';
      price = double.parse('45');
      size = "";
      description = "";
      images = "";
      qty = 1;
      totalPrice = qty * price;
      taste = "";

      Order e = Order(foodID, foodsName, price, size, description, images, qty,
          totalPrice, taste, comment);

      dbHelper.save(e);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyOrder()),
      );
    } else {
      dbHelper.updateBySQL(foodsID: foodID);


      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyOrder()),
      );
    }
  }


}








