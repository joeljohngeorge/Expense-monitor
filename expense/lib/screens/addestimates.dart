import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Estimateaddpage extends StatefulWidget {
  @override
  _EstimateaddpageState createState() => _EstimateaddpageState();
}

class _EstimateaddpageState extends State<Estimateaddpage> {
  final _percentagecon = TextEditingController();
  var _categories = [
    'Finance',
    'Education',
    'Groceries',
    'Food',
    'Health',
    'Entertainment',
    'Shopping',
    'Home & Utilities',
    'Electricity Bill',
    'Water Bill',
    'Others'
  ];
  var _currentitemselected = 'Finance';
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
    var url = "https://expensemonitor.000webhostapp.com/user/addbudget.php";
    var data = {
      "user_id": emailId,
      "category": _currentitemselected,
      "amount": _percentagecon.text,
    };

    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "added successfully", toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(msg: "Error!!", toastLength: Toast.LENGTH_SHORT);
    }

    setState(() {
      processing = false;
    });
  }

  void _submit1() {
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
            title: Center(
          child: Text("Add estimation",
              style: TextStyle(
                fontSize: 18,
              )),
        )),
        body: SingleChildScrollView(
            child: Container(
                height: 2000,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                        key: formKey,
                        child: Column(children: [
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
                          TextFormField(
                              style: TextStyle(fontSize: 22),
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.category),
                                  labelText: 'Enter estimated percentage',
                                  labelStyle: TextStyle(fontSize: 16)),
                              controller: _percentagecon,
                              keyboardType: TextInputType.number,
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
                              addestimates();
                              _submit1();
                            },
                            child: new Text('Submit'),
                          ),
                        ]))))));
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentitemselected = newValueSelected;
    });
  }
}
