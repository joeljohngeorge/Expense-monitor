import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'budgetplanning.dart';

class Incomeaddpage extends StatefulWidget {
  @override
  _IncomeaddpageState createState() => _IncomeaddpageState();
}

class _IncomeaddpageState extends State<Incomeaddpage> {
  @override
  var emailId;
  bool processing = false;
  final _incomecon = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void getValues() async {
    print('Getting Values from shared Preferences');
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    emailId = sharedPrefs.getString('email');
    print('user_name: $emailId');
  }

  @override
  void initState() {
    super.initState();
    getValues();
  }

  void addincome() async {
    setState(() {
      processing = true;
    });

    var url = "https://expensemonitor.000webhostapp.com/user/addincome.php";
    var data = {
      "user_id": emailId,
      "amount": _incomecon.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "income added", toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "not updated") {
        Fluttertoast.showToast(
            msg: "not updated", toastLength: Toast.LENGTH_SHORT);
      } else {
        if (jsonDecode(res.body) == "not added") {
          Fluttertoast.showToast(
              msg: "not added", toastLength: Toast.LENGTH_SHORT);
        } else {
          Fluttertoast.showToast(
              msg: "Error!!", toastLength: Toast.LENGTH_SHORT);
        }
      }
    }

    setState(() {
      processing = false;
    });
  }

  /*void _submit2() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.pop(context);
    }
  }
*/
  Widget build(BuildContext context) {
    /*final _incomecon = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool processing = false;
    var emailId;

    void getValues() async {
      print('Getting Values from shared Preferences');
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      emailId = sharedPrefs.getString('email');
      print('user_name: $emailId');
    }

    @override
    void initState() {
      super.initState();
      getValues();
    }*/

    // Future<Null> mail = getMethod1();

    /*void addincome() async {
      setState(() {
        processing = true;
      });

      var url = "https://expensemonitor.000webhostapp.com/user/addincome.php";
      var data = {
        "user_id": emailId,
        "amount": _incomecon.text,
      };

      var res = await http.post(url, body: data);

      if (jsonDecode(res.body) == "true") {
        Fluttertoast.showToast(
            msg: "income added", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: "error", toastLength: Toast.LENGTH_SHORT);
      }

      setState(() {
        processing = false;
      });
    }*/

    void _submit2() {
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(
            title: Center(
          child: Text("Enter income",
              style: TextStyle(
                fontSize: 18,
              )),
        )),
        body: Container(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    TextFormField(
                        style: TextStyle(fontSize: 22),
                        decoration: const InputDecoration(
                            icon: const Icon(Icons.monetization_on),
                            labelText: 'Enter income',
                            labelStyle: TextStyle(fontSize: 16)),
                        keyboardType: TextInputType.number,
                        controller: _incomecon,
                        validator: (val) {
                          Pattern pattern = r'^[1-9]\d*(\.\d+)?$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(val))
                            return 'Enter a valid number';
                          else
                            return null;
                        }),
                    SizedBox(height: 30),
                    RaisedButton(
                      onPressed: () {
                        addincome();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Budgetplanning()),
                        );
                      },
                      child: new Text('Submit'),
                    ),
                  ]),
                ))));
  }
}
