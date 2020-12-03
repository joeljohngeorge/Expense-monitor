/*import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'budget.dart';
import 'income.dart';
import 'services.dart';
import 'package:expense/screens/addincome.dart';
import 'package:expense/screens/addestimates.dart';

class Budgetplanning extends StatefulWidget {
  @override
  _BudgetplanningState createState() => _BudgetplanningState();
}

class _BudgetplanningState extends State<Budgetplanning> {
  var emailId;
  List<Budget> _budget;
  List<Income> _income;
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool _isUpdating;

  @override
  void initState() {
    super.initState();
    getValues();
    _budget = [];
    _income = [];
    _isUpdating = false;
    //_titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    //_firstNameController = TextEditingController();
    //_lastNameController = TextEditingController();
    _getBudget();
    _getIncome();
  }

  void getValues() async {
    print('Getting Values from shared Preferences');
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    emailId = sharedPrefs.getString('email');
    print('user_name: $emailId');
  }

  _getIncome() {
    //_showProgress('Loading Expenses...');
    Services.getIncome(emailId).then((income) {
      setState(() {
        _income = income;
      });
      //_showProgress(widget.title);
      print("Length: ${income.length}");
    });
  }

  _getBudget() {
    //_showProgress('Loading Expenses...');
    Services.getBudget(emailId).then((budget) {
      setState(() {
        _budget = budget;
      });
      //_showProgress(widget.title);
      print("Length: ${budget.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Budget Planning",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getBudget();
                _getIncome();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              height: 3500,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SizedBox(height: 30),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Incomeaddpage()),
                        );
                      },
                      child: Text("Add income")),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Estimateaddpage()),
                        );
                      },
                      child: Text("Add estimates")),
                ),
                SizedBox(
                  height: 30,
                ),
                DataTable(columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Income',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ], rows: <DataRow>[
                  DataRow(cells: [
                    DataCell(Text(income.income)),
                  ]),
                ]),
                SizedBox(
                  height: 30,
                ),
                DataTable(columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Expected balance',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ], rows: <DataRow>[
                  DataRow(cells: [
                    DataCell(Text(income.amount)),
                  ]),
                ]),
                SizedBox(
                  height: 30,
                ),
                DataTable(columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Savings',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ], rows: <DataRow>[
                  DataRow(cells: [
                    DataCell(Text('3000')),
                  ]),
                ]),
                SizedBox(
                  height: 30,
                ),
                DataTable(
                  columns: [
                    DataColumn(
                        label: Text("CATEGORY"),
                        numeric: false,
                        tooltip: "This is the CATEGORY"),
                    DataColumn(
                        label: Text(
                          "PERCENT%",
                        ),
                        numeric: false,
                        tooltip: "This is the PERCENT"),
                  ],
                  rows: _budget
                      .map(
                        (budget) => DataRow(
                          cells: [
                            DataCell(
                              Text(budget.category),
                            ),
                            DataCell(
                              Text(
                                budget.percent,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ])),
        ));
  }
}




SingleChildScrollView(
          child: Container(
              height: 3500,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SizedBox(height: 30),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Incomeaddpage()),
                        );
                      },
                      child: Text("Add income")),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Estimateaddpage()),
                        );
                      },
                      child: Text("Add estimates")),
                ),
                SizedBox(
                  height: 30,
                ),
                DataTable(columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Income',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ], rows: <DataRow>[
                  DataRow(cells: [
                    DataCell(Text(_income.title)),
                  ]),
                ]),
                SizedBox(
                  height: 30,
                ),
                DataTable(columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Expected balance',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ], rows: <DataRow>[
                  DataRow(cells: [
                    DataCell(Text(_income.value)),
                  ]),
                ]),
                SizedBox(
                  height: 30,
                ),
                DataTable(columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Savings',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ], rows: <DataRow>[
                  DataRow(cells: [
                    DataCell(Text('3000')),
                  ]),
                ]),
                SizedBox(
                  height: 30,
                ),
                DataTable(
                  columns: [
                    DataColumn(
                        label: Text("CATEGORY"),
                        numeric: false,
                        tooltip: "This is the CATEGORY"),
                    DataColumn(
                        label: Text(
                          "PERCENT%",
                        ),
                        numeric: false,
                        tooltip: "This is the PERCENT"),
                  ],
                  rows: _budget
                      .map(
                        (budget) => DataRow(
                          cells: [
                            DataCell(
                              Text(budget.category),
                            ),
                            DataCell(
                              Text(
                                budget.percent,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ])),

        ));
  }
}

*/
