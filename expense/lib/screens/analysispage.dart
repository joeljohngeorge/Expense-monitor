import 'package:flutter/material.dart';

class Analysispage extends StatefulWidget {
  @override
  _AnalysispageState createState() => _AnalysispageState();
}

class _AnalysispageState extends State<Analysispage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text("Analysis & Review",
            style: TextStyle(
              fontSize: 18,
            )),
      )),
    );
  }
}
