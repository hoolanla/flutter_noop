
import 'package:flutter/material.dart';
import 'package:flutternoop/CovidReport.dart';
import 'package:flutternoop/Global.dart' as globals;




main()  {
  runApp(new App());
}

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}
class _AppState extends State<App> {

  final ThemeData androidTheme = new ThemeData(
      accentColor: Colors.black45,
      primaryColor: Colors.green);



  @override
  Widget build(BuildContext context) {


    globals.userName = 'somchai';
    globals.lastName = 'lastname';

    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eMenu',
        theme: androidTheme,
        initialRoute: '/',
        routes: <String, Widget Function(BuildContext)>{



          '/': (context) => CovidReport(projectID: 'projectID',memberID: 'memID',),
//          '/MyOrder': (context) => MyOrder(),
//          '/FirstPage': (context) => FirstPage(),
//          '/Login': (context) => Login(),

//         '/': (context) => Login(),
        }
    );
  }
}




