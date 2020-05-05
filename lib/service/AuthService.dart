import 'package:flutternoop/Model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutternoop/Global.dart' as globals;

class AuthService {
  static final String DISPLAYNAME = "displayName";
  static final String IMAGEPATH = "imagePath";
  static final String IS_LOGIN = "is_login";
  static final String TYPE = "type";
  static final String EMAIL = "email";
  static final String USERID = "userid";
  static final String TEL = "tel";
  static final String LASTNAME = "lastname";


  static final String REST_ID = "restuarantID";
  static final String TABLE_ID = "tableID";



  Future LoginEmail({User user}) async {
    //By email
    if (user.email == "admin@gmail.com" && user.password == "123456") {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString(EMAIL, user.email);
      _pref.setString(DISPLAYNAME, user.Displayname);


      return true;
    }

    else
    {
      return false;
    }
  }

  Future Login({User user}) async {
    if (user.Displayname != "") {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString(DISPLAYNAME, user.Displayname);
      _pref.setString(IMAGEPATH, user.imagePath);
      _pref.setString(TYPE, user.type);
      _pref.setString(EMAIL, user.email);
      _pref.setBool(IS_LOGIN, true);
      return true;
    }
    else
    {
      return false;
    }
  }



  Future<bool> isLogin() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getBool(IS_LOGIN) ?? false;
  }

  Future logout() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.remove(IS_LOGIN);
    return await Future<void>.delayed(Duration(seconds: 1));
  }

  Future getDisplayName() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(DISPLAYNAME);
  }

  Future getImage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(IMAGEPATH);
  }


  Future getRestuarantID() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(REST_ID);
  }

  Future getTableID() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(TABLE_ID);
  }


  Future getEmail() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(EMAIL);
  }


  Future getUserID() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(USERID);
  }

}
