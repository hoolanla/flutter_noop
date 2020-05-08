import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


String mImage;
String mRestaurantName;


void main() {
  runApp(new QRcode());
}

class QRcode extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<QRcode> {

  String _barcode = "";


  @override
  initState() {
    super.initState();
    scan();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        child: new Scaffold(
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
           //   onPressed: () => _onBackPress(),
            ),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                ),
                Text(''),

              ],
            ),
          ),
          /*     floatingActionButton: FloatingActionButton.extended(
              onPressed: scan,
              label: Text(
                'Scan',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,*/
        ),
        onWillPop: null,),
    );
  }



  Future scan() async {
     _barcode = await BarcodeScanner.scan();
  }
}

