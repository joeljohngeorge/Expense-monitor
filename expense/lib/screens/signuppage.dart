//import 'package:expense/screens/login.dart';
import 'dart:convert';
//J$Ql)nb5k)N7q$t2s6MX
//+5-nB&)]vJ(7Q3<3
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart';

class Signuppage extends StatefulWidget {
  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  bool _isHidden = true;
  bool processing = false;
  final _passcon = TextEditingController();
  final _idcon = TextEditingController();
  final _confirmpasscon = TextEditingController();
  final _namecon = TextEditingController();
  bool _validatePass = false;
  final snackBar =
      SnackBar(content: Text('Signed up successfully.Go to loginpage'));

  bool _validateConPass = false;
  bool _validateName = false;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void registerUser() async {
    setState(() {
      processing = true;
    });
    var url = "https://expensemonitor.000webhostapp.com/user/signup.php";
    var data = {
      "id": _idcon.text,
      "name": _namecon.text,
      "password": _passcon.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "account already exists") {
      Fluttertoast.showToast(
          msg: "account exists, Please login", toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "true") {
        Fluttertoast.showToast(
            msg: "account created,please login",
            toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: "error", toastLength: Toast.LENGTH_SHORT);
      }
    }
    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign up", style: TextStyle(fontSize: 25))),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding:
            EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            builduserid("User id"),
            SizedBox(
              height: 20.0,
            ),
            buildname("Name"),
            SizedBox(
              height: 20.0,
            ),
            buildpassword("Password"),
            SizedBox(
              height: 20.0,
            ),
            buildconfirmpassword("Confirm password"),
            SizedBox(height: 20.0),
            Container(
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  buildButtonSignup(),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildpassword(String hintText) {
    return TextField(
      controller: _passcon,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: hintText == "Password"
            ? IconButton(
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
        errorText: _validatePass
            ? 'Password should not be null.Atleast 8 characters'
            : null,
      ),
      obscureText: hintText == "Password" ? _isHidden : false,
    );
  }

  Widget buildconfirmpassword(String hintText) {
    return TextField(
      controller: _confirmpasscon,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: hintText == "Confirm password"
            ? IconButton(
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
        errorText: _validateConPass ? 'Passwords do not match.' : null,
      ),
      obscureText: hintText == "Confirm password" ? _isHidden : false,
    );
  }

  Widget buildname(String hintText) {
    return TextField(
        controller: _namecon,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(Icons.person),
          errorText: _validateName ? 'Enter a name.' : null,
        ));
  }

  Widget builduserid(String hintText) {
    return TextField(
        controller: _idcon,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(Icons.email),
          errorText: _validateName ? 'Enter a user id.' : null,
        ));
  }

  Widget buildButtonSignup() {
    return RaisedButton(
      onPressed: () {
        setState(() {
          if (_passcon.text.isEmpty || _passcon.text.length < 8) {
            _validatePass = true;
          } else {
            _validatePass = false;
          }
          if (_namecon.text.isEmpty) {
            _validateName = true;
          } else {
            _validateName = false;
          }
          if ((_confirmpasscon.text != _passcon.text) ||
              _confirmpasscon.text.length < 8) {
            _validateConPass = true;
          } else {
            _validateConPass = false;
          }

          if (_validateName == false &&
              _validatePass == false &&
              _validateConPass == false &&
              _validatePass == false) {
            registerUser();
          }
        });
        // registerUser() {}
      },
      color: Colors.orangeAccent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text(
        "Sign up",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );
  }
}
