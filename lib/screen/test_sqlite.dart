import 'package:flutter/material.dart';
import 'package:flutternoop/Sqlite/db_helper.dart';






class TestSqlite extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestSqliteState();
  }
  
}
class TestSqliteState extends State<TestSqlite>{



  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sqlite'),
      ),
        body: new Container(
            child: new Center(
                child: new Column(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      Container(
//                          margin: const EdgeInsets.only(
//                              left: 0.0, right: 0.0, top: 0.0),
//                          padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
//                          child: Image.asset(
//                            'assets/images/CovidFoodLogoBar.png',
//                            fit: BoxFit.cover,
//                          )),
//                      new Padding(
//                        padding: const EdgeInsets.all(28.0),
//                        child: Container(
//                          alignment: Alignment.topCenter,
//                          child: Image.asset(
//                            'assets/images/CovidFoodLogo1.png',
//                            width: 200.0,
//                            height: 200.0,
//                          ),
//                        ),
//                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.pinkAccent,
                          elevation: 0.0,
                          child: new MaterialButton(
                              minWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment(-1,0),
                                    width: 80,
                                    child: new Icon(Icons.store_mall_directory,
                                      color: Colors.yellow,),
                                  ),
                                  Container(
                                    alignment: Alignment(0,0),
                                    child: new Text("Create Database",
                                        style: new TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20.0,
                                          fontFamily: 'Kanit',
                                        )),
                                  ),
                                ],
                              ),
                              onPressed: () {






                              }
                            //gotoWebView();
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.cyan,
                          elevation: 0.0,
                          child: new MaterialButton(

                              minWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Row(

                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            alignment: Alignment(-1, 0),
                                            width: 80,
                                            child: new Icon(Icons.fastfood,
                                              color: Colors.yellow,
                                            )),
                                        Container(
                                          alignment: Alignment(0, 0),
                                          child: new Text(
                                            "Test 2",
                                            style: new TextStyle(
                                              color: Colors.white,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 20.0,
                                              fontFamily: 'Kanit',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              onPressed: () {

                              }),
                        ),
                      ),
                    ]))));
  }
  
}