import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutternoop/Global.dart' as globals;

class AlertService {
  final String title;
  final String desc;

  AlertService({
    this.title,
    this.desc
  });

  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(
        fontWeight: FontWeight.normal, fontFamily: 'Kanit', fontSize: 14),
    animationDuration: Duration(milliseconds: 400),

    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );


  void showAlertFirstRun(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.none,
      title: "COVID-19",
      desc: "เนื่องด้วยสถานการณ์โควิดที่เกินขึ้นตอนนี้ APP จะเปิดให้สั่งอาหารได้เฉพาะ ช่วงเวลา 21:00 - 04:00",
      style: alertStyle,
      buttons: [
        DialogButton(
            child: Text(
              "OK",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Kanit',
              ),
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            }),
      ],
    ).show();
  }



}



