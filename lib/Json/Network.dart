

import 'package:flutternoop/Model/Covid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Network {
  static Future<Covid> loadCovid ()
  async {
    String url = 'https://covid19.th-stat.com/api/open/today';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"},);
    final jsonResponse = json.decode(response.body.toString());
    Covid _covid = new Covid.fromJson(jsonResponse);
   return _covid;
  }

}