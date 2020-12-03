import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'budget.dart';
import 'income.dart';
import 'services.dart';
import 'package:expense/screens/addincome.dart';
import 'package:expense/screens/addestimates.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Budgetplanning extends StatefulWidget {
  @override
  _BudgetplanningState createState() => _BudgetplanningState();
}

class _BudgetplanningState extends State<Budgetplanning> {
  var emailId;
  var index = 0;
  List<Income> _income; //= List<Income>();
  List<Budget> _budget;
  //List<Income> _income;
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool _isUpdating;

  @override
  void initState() {
    fetchIncome(emailId).then((value) {
      setState(() {
        _income.addAll(value);
      });
    });
    super.initState();
    getValues();
    _budget = [];
    //_income = [];
    _isUpdating = false;
    _scaffoldKey = GlobalKey();
    _getBudget();
    // _getIncome();
  }

  void getValues() async {
    print('Getting Values from shared Preferences');
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    emailId = sharedPrefs.getString('email');
    print('user_name: $emailId');
  }

  void _getIncome() async {
    setState(() {
      // processing = true;
    });
    var url = "https://expensemonitor.000webhostapp.com/user/displayincome.php";
    var data = {
      "user_id": emailId,
      //"category": _currentitemselected,
      //"per": _percentagecon.text,
    };

    var res = await http.post(url, body: data);
  }

  Future<List<Income>> fetchIncome(String emailId) async {
    var url = 'https://expensemonitor.000webhostapp.com/user/displayincome.php';
    var data = {
      "user_id": emailId,
    };
    var res = await http.post(url, body: data);

    var income = List<Income>();

    if (res.statusCode == 200) {
      var incomeJson = json.decode(res.body);
      for (var incomeJson in incomeJson) {
        income.add(Income.fromJson(incomeJson));
      }
    }
    return income;
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
                // _getIncome();
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
                /* DataTable(columns: <DataColumn>[
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
                    DataCell(Text("30000")),
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
                    DataCell(Text('25000')),
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
                ]),*/
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

/*override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter listview with json'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _income[index].title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _income[index].text,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _income.length,
        ));
  }
}*/
