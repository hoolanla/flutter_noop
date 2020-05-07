
import 'package:flutter/material.dart';
import 'package:flutternoop/Model/Covid.dart';
import 'dart:async';
import 'package:flutternoop/Json/Network.dart';
import 'package:flutternoop/Global.dart' as globals;
Future<Covid> resultCovid;

void main() {
  runApp(CovidReport());
}

class CovidReport extends StatefulWidget {
  final String projectID  ;
  final String memberID  ;
  CovidReport({this.projectID,this.memberID});

  @override
  State<StatefulWidget> createState() {
    return _ShowData();
  }
}

class _ShowData extends State<CovidReport> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var dbHelper;
  bool isUpdating;
  @override
  void initState() {
    super.initState();
    refreshCovid();
  }

  refreshCovid() {
    setState(() {
      resultCovid = Network.loadCovid();
    });
  }



  Widget _ListShow({Covid cov}) => ListView.builder(
    itemBuilder: (context,int idx) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 1.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 1.0,
              ),
              child: Container(
                child: new ListTile(
                  onTap: () {

                  },
                  title: Text('New confirm' +
                 cov.NewConfirmed.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kanit',
                      color: Colors.deepOrange,
                    ),
                  ),
                  subtitle: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Text( 'Recovered :' + cov.Recovered,
                            style: TextStyle(
                              fontFamily: 'Kanit',
                            ),
                          )
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          Text( 'Hospitalized :' + cov.Hospitalized,
                            style: TextStyle(
                              fontFamily: 'Kanit',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                 trailing: Icon(Icons.arrow_forward_ios,size: 16,)
                ),
                decoration: new BoxDecoration(
                  border: Border(
                    bottom: new BorderSide(
                      color: Colors.cyan,
                      width: 0.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
    itemCount: 1,

  );

  Widget ReturnText()
  {
    return Text('${widget.memberID.toString()}' + '    ' + widget.projectID.toString(),
    style: TextStyle(fontFamily: 'Kanit',fontWeight: FontWeight.normal,fontSize: 25),);
  }

  Widget ReturnText2()
  {
    return Text('${widget.memberID.toString()}' + '    ' + widget.projectID.toString(),
      style: TextStyle(fontWeight: FontWeight.normal,fontSize: 25),);
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
        trailing: Text(
          'สถานะ ',
          style: TextStyle(
            fontFamily: 'Kanit',
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


  listCovid() {
    return Expanded(
      child: FutureBuilder<Covid>(
          future: resultCovid,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                  return new Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Expanded(
                        child: _ListShow(cov: snapshot.data),
                      ),
                    ],
                  );
              }
              else
              {
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
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
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
          }),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//        textTheme: TextTheme(
//          title: TextStyle(
//            color: Colors.black,
//            fontSize: 20.0,
//            fontFamily: 'Kanit',
//          ),
//        ),
//        backgroundColor: Colors.cyan,
//        title: new Text(
//          'Covid Report',
//          textAlign: TextAlign.center,
//          style: TextStyle(
//            color: Colors.white,
//            fontWeight: FontWeight.normal,
//            fontSize: 20.0,
//            fontFamily: 'Kanit',
//          ),
//        ),
//      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
          //  ReturnText(),

          //  ReturnText2(),
           // HeaderColumn(),
            listCovid(),
          ],
        ),
      ),

    );
  }
}








