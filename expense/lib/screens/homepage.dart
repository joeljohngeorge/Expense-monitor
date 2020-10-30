import 'package:expense/screens/analysispage.dart';
import 'package:expense/screens/billsplitting.dart';
import 'package:expense/screens/budgetplanning.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
      ),
      drawer: Navdrawer(),
    );
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
          onTap: () => {},
        ),
      ]),
    );
  }
}
