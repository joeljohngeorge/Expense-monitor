import 'package:expense/screens/addbillsplit.dart';
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
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: "Split bill",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Billsplitaddpage()),
              );
            }),
        body: SingleChildScrollView(
          child: Container(
            height: 2000,
            width: MediaQuery.of(context).size.width,
            child: DataTable(columnSpacing: 24, columns: <DataColumn>[
              DataColumn(
                label: Text(
                  'Category',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Total',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Friends',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Amount/person',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
                //Expected  data
                rows: <DataRow>[
                  DataRow(cells: [
                    DataCell(Text('Entertainment')),
                    DataCell(Text('1200')),
                    DataCell(Text('4')),
                    DataCell(Text('300')),
                  ]),
                ]),
          ),
        ));
  }
}
