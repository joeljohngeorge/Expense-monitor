import 'package:expense/screens/analysispage.dart';
import 'package:expense/screens/billsplitting.dart';
import 'package:expense/screens/budgetplanning.dart';
import 'package:expense/screens/expenseaddpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'expenses.dart';
import 'services.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Homepage());

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var emailId;
  List<Expenses> _expenses;
  GlobalKey<ScaffoldState> _scaffoldKey;
  Expenses _selectedexpense;
  bool _isUpdating;
  String _titleProgress;

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
    _expenses = [];
    _isUpdating = false;
    _scaffoldKey = GlobalKey();
    _getExpenses(emailId);
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getExpenses(String emailId) {
    Services.getExpenses(emailId).then((expenses) {
      setState(() {
        _expenses = expenses;
      });
      print("Length: ${expenses.length}");
    });
  }

  _deleteExpenses(Expenses expenses) {
    _showProgress('Deleting Employee...');
    Services.deleteExpenses(expenses.description).then((result) {
      if ('success' == result) {
        setState(() {
          _expenses.remove(expenses);
        });
        _getExpenses(emailId);
      }
    });
  }

  showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text("DESCRIPTION"),
                numeric: false,
                tooltip: "This is the DESCRIPTION"),
            DataColumn(
                label: Text(
                  "AMOUNT",
                ),
                numeric: false,
                tooltip: "This is the AMOUNT"),
            DataColumn(
                label: Text("DATE"),
                numeric: false,
                tooltip: "This is the DATE"),
            DataColumn(
                label: Text("DELETE"),
                numeric: false,
                tooltip: "Delete Action"),
          ],
          rows: _expenses
              .map(
                (expenses) => DataRow(
                  cells: [
                    DataCell(
                      Text(expenses.description),
                      /*onTap: () {
                        print("Tapped " + expenses.firstName);
                        _setValues(expenses);
                        _selectedEmployee = expenses;
                      },*/
                    ),
                    DataCell(
                      Text(
                        expenses.amount,
                      ),
                      /* onTap: () {
                        print("Tapped " + employee.firstName);
                        _setValues(employee);
                        _selectedEmployee = employee;
                      },*/
                    ),
                    DataCell(
                      Text(
                        expenses.date,
                      ),
                      /* onTap: () {
                        print("Tapped " + employee.firstName);
                        _setValues(employee);
                        _selectedEmployee = employee;
                      },*/
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteExpenses(expenses);
                        },
                      ),
                      /* onTap: () {
                        print("Tapped " + expenses.description);
                      },*/
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Center(
              child: Text("Expense Monitor",
                  style: TextStyle(
                    fontSize: 18,
                  ))),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getExpenses(emailId);
              },
            ),
          ],
        ),
        drawer: Navdrawer(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: "Add expense",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Expenseaddpage()),
              );
            }),
        body: Container(
          child: _dataBody(),
        ));
  }
}

class Navdrawer extends StatefulWidget {
  @override
  _NavdrawerState createState() => _NavdrawerState();
}

class _NavdrawerState extends State<Navdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Text(
              'Expense Monitor',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        ListTile(
          title: Text("Home"),
          onTap: () => {Navigator.of(context).pop()},
        ),
        ListTile(
          title: Text("Budget Planning"),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Budgetplanning()))
          },
        ),
        ListTile(
          title: Text("Analysis & Review"),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Analysispage()))
          },
        ),
        ListTile(
          title: Text("Bill splitting"),
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Billsplitting()))
          },
        ),
        ListTile(
          title: Text("Log out"),
          onTap: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()))
          },
        ),
      ]),
    );
  }
}
