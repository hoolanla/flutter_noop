import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutternoop/Global.dart' as globals;
import 'package:google_maps_flutter/google_maps_flutter.dart';



String _locationMessage;


class ShowLocation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowLocationState();
  }
  
}
class ShowLocationState extends State<ShowLocation>{


  @override
  initState() {
    super.initState();
    _getCurrentLocation();
  }


  void _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";

      print (_locationMessage);



      globals.latitude = "${position.latitude}";
      globals.longtitude = "${position.longitude}";
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(



      body: Container(
        child: Column(
          children: <Widget>[

            Text('Location ' + _locationMessage),

          ],
        ),
      )

    );
  }
  
}