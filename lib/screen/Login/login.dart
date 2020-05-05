
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutternoop/Model/User.dart';
import 'package:flutternoop/service/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';



final User _user = new User();
final String DISPLAYNAME = "displayName";
final String IMAGEPATH = "imagePath";
final String EMAIL = 'email';
final String USERID = "userid";
final String TEL = "tel";
final String LASTNAME = "lastname";
final String IS_LOGIN = "is_login";

void main() => runApp(Login());

class Login extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<Login> {
  AuthService authService = AuthService();
 // RetLogin _letLogin;

  static final TextEditingController _textTel = TextEditingController();

  String tel;
  String password;

  final _formKey = GlobalKey<FormState>();
  bool hidePass = true;
  bool _result = false;
  FocusNode passwordFocusNode = FocusNode();

  var dbHelper;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    void _showAlertDialog({String strError}) async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(strError),
              content: Text(
                "Please try again.",
                style: TextStyle(
                  fontFamily: 'Kanit',
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontFamily: 'Kanit',
                    ),
                  ),
                )
              ],
            );
          });
    }



    void _submit() async {
      if (this._formKey.currentState.validate()) {
        _formKey.currentState.save();
        SharedPreferences _pref = await SharedPreferences.getInstance();
       // SendtoJsonLogin(tel: tel, password: password, type_: globals.typeUser);
      }
    }

    double height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
                padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                child: Image.asset(
                  'assets/images/CovidFoodLogoBar.png',
                  fit: BoxFit.cover,
//                height: 240.0,
                )),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/CovidFoodLogo1.png',
                    width: 120.0,
//                height: 240.0,
                  )),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                  title: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Telephone',
                                      icon: Icon(Icons.phone),
                                    ),
                                  //  validator: _validateTel,
                                    controller: _textTel,
                                    onSaved: (String value) {
                                      tel = value;
                                    },
                                    onFieldSubmitted: (String value) {
                                      FocusScope.of(context)
                                          .requestFocus(passwordFocusNode);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                  title: TextFormField(
                                    //  controller: _passwordTextController,
                                    focusNode: passwordFocusNode,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      icon: Icon(Icons.lock_outline),
                                    ),
                                    obscureText: hidePass,
                                 //   validator: _validatePassword,
                                    onSaved: (String value) {
                                      password = value;
                                    },
                                   onFieldSubmitted: (String value) {},
                                  ),
                                  trailing: IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        setState(() {
                                          hidePass = !hidePass;
                                        });
                                      }),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.pinkAccent,
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: _submit,
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Forgot password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap: () {

                                      },
                                      child: Text(
                                        "Create an account",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ))),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }



bool isLoggedIn = false;









