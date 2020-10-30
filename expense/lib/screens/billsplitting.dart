import 'package:flutter/material.dart';

class Billsplitting extends StatefulWidget {
  @override
  _BillsplittingState createState() => _BillsplittingState();
}

class _BillsplittingState extends State<Billsplitting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text("Bill splitting",
            style: TextStyle(
              fontSize: 18,
            )),
      )),
    );
  }
}
