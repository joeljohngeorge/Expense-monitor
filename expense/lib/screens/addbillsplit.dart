import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Billsplitaddpage extends StatefulWidget {
  @override
  _BillsplitaddpageState createState() => _BillsplitaddpageState();
}

class _BillsplitaddpageState extends State<Billsplitaddpage> {
  var _categories = [
    'Food',
    'Transportation',
    'Health',
    'Entertainment',
    'Shopping',
    'Others'
  ];
  var _currentitemselected = 'Entertainment';
  final _billamtcon = TextEditingController();
  final _numcon = TextEditingController();
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
  }

  void addestimates() async {
    setState(() {
      processing = true;
    });
    var url = "https://expensemonitor.000webhostapp.com/user/addbill.php";
    var data = {
      "user_id": emailId,
      "category": _currentitemselected,
      "total amount": _billamtcon.text,
      "numfrnds": _numcon.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "updated") {
      Fluttertoast.showToast(msg: "updated", toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "updation failed!!") {
        Fluttertoast.showToast(
            msg: "updation failed!!", toastLength: Toast.LENGTH_SHORT);
      } else {
        if (jsonDecode(res.body) == "budget added") {
          Fluttertoast.showToast(
              msg: "Added successfully", toastLength: Toast.LENGTH_SHORT);
        } else {
          if (jsonDecode(res.body) == "insertion failed!!!") {
            Fluttertoast.showToast(
                msg: "insertion failed!!!", toastLength: Toast.LENGTH_SHORT);
          } else {
            Fluttertoast.showToast(
                msg: "Error!!", toastLength: Toast.LENGTH_SHORT);
          }
        }
      }
    }

    setState(() {
      processing = false;
    });
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter Bill splitting details'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: formKey,
                child: Column(children: [
                  TextFormField(
                    style: TextStyle(fontSize: 22),
                    decoration: const InputDecoration(
                        icon: const Icon(Icons.monetization_on),
                        labelText: ' Total Amount',
                        labelStyle: TextStyle(fontSize: 16)),
                    validator: (val) {
                      Pattern pattern = r'^[1-9]\d*(\.\d+)?$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(val))
                        return 'Enter a valid number';
                      else
                        return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: _billamtcon,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 22),
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.group),
                      labelText: ' No.of Friends',
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                    validator: (val) {
                      Pattern pattern = r'^[1-9]\d*(\.\d+)?$';

                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(val)) {
                        return 'Enter a valid number';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: _numcon,
                  ),
                  DropdownButton<String>(
                    items: _categories.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String newValueSelected) {
                      _onDropDownItemSelected(newValueSelected);
                    },
                    value: _currentitemselected,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () {
                      _submit();
                    },
                    child: new Text('Submit'),
                  )
                ]))));
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentitemselected = newValueSelected;
    });
  }
}
