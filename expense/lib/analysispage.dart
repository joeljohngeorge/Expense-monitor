import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense/screens/income.dart';
import 'review.dart';
import 'services.dart';
import 'package:http/http.dart' as http;

class Analysispage extends StatefulWidget {
  @override
  _AnalysispageState createState() => _AnalysispageState();
}

class _AnalysispageState extends State<Analysispage> {
  var _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  var _currentitemselected = 'January';

  var emailId;
  List<Review> _review;
  GlobalKey<ScaffoldState> _scaffoldKey;
  Review _selectedexpense;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    getValues();
    _review = [];
    _isUpdating = false;
    //_titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    //_firstNameController = TextEditingController();
    //_lastNameController = TextEditingController();
    _getReview();
  }

  void getValues() async {
    print('Getting Values from shared Preferences');
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    emailId = sharedPrefs.getString('email');
    print('user_name: $emailId');
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getReview() {
    //_showProgress('Loading Expenses...');
    Services.getReview(emailId, _currentitemselected).then((review) {
      setState(() {
        _review = review;
      });
      //_showProgress(widget.title);
      print("Length: ${review.length}");
    });
  }

  showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  /* SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text("CATEGORY"),
                numeric: false,
                tooltip: "This is the CATEGORY"),
            DataColumn(
                label: Text(
                  "AMOUNT ESTIMATED",
                ),
                numeric: false,
                tooltip: "This is the AMOUNT ESTIMATED"),
            DataColumn(
                label: Text("AMOUNT SPENT"),
                numeric: false,
                tooltip: "This is the AMOUNT SPEND"),
          ],
          rows: _review
              .map(
                (review) => DataRow(
                  cells: [
                    DataCell(
                      Text(review.category),
                    ),
                    DataCell(
                      Text(
                        review.estamount,
                      ),
                    ),
                    DataCell(
                      Text(
                        review.totalamount,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Analysis & Review",
                style: TextStyle(
                  fontSize: 18,
                )),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getReview();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 3500,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                DropdownButton<String>(
                  items: _months.map((String dropDownStringItem) {
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
                SizedBox(height: 25),
                Center(
                    child: Text(
                  "REVIEW TABLE",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                SizedBox(height: 10),
                DataTable(
                  columns: [
                    DataColumn(
                        label: Text("Category"),
                        numeric: false,
                        tooltip: "This is the CATEGORY"),
                    DataColumn(
                        label: Text(
                          "Estimated",
                        ),
                        numeric: false,
                        tooltip: "This is the AMOUNT ESTIMATED"),
                    DataColumn(
                        label: Text("Spent"),
                        numeric: false,
                        tooltip: "This is the AMOUNT SPEND"),
                  ],
                  rows: _review
                      .map(
                        (review) => DataRow(
                          cells: [
                            DataCell(
                              Text(review.category),
                            ),
                            DataCell(
                              Text(
                                review.estamount,
                              ),
                            ),
                            DataCell(
                              Text(
                                review.totalamount,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ));
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentitemselected = newValueSelected;
    });
  }
}
