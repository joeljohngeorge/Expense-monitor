import 'package:flutter/material.dart';

class Incomeaddpage extends StatefulWidget {
  @override
  _IncomeaddpageState createState() => _IncomeaddpageState();
}

class _IncomeaddpageState extends State<Incomeaddpage> {
  @override
  Widget build(BuildContext context) {
    final _incomecon = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void _submit2() {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        Navigator.pop(context);
      }
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
                        _submit2();
                      },
                      child: new Text('Submit'),
                    ),
                  ]),
                ))));
  }
}
