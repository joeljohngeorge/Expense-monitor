import 'package:flutter/material.dart';

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
    'Food & Restaurants',
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
