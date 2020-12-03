import 'dart:convert';
import 'package:expense/screens/budget.dart';
import 'package:http/http.dart' as http;
import 'expenses.dart';
import 'package:expense/screens/review.dart';
import 'package:expense/screens/income.dart';

class Services {
  static const ROOT =
      'https://expensemonitor.000webhostapp.com/user/displayexpense.php';
  static const String _GET_ACTION = 'GET_ALL';
  //static const String _CREATE_TABLE = 'CREATE_TABLE';
  //static const String _ADD_EMP_ACTION = 'ADD_EMP';
  //static const String _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const String _DELETE_EMP_ACTION = 'DELETE_EMP';

  static Future<List<Expenses>> getExpenses(String userid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      map["user_id"] = userid;
      final response = await http.post(ROOT, body: map);
      print("getExpenses>> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Expenses> list = parsePhotos(response.body);
        return list;
      } else {
        throw List<Expenses>();
      }
    } catch (e) {
      return List<Expenses>();
    }
  }

  static List<Expenses> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Expenses>((json) => Expenses.fromJson(json)).toList();
  }

  static Future<List<Budget>> getBudget(String userid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      map["user_id"] = userid;
      final response = await http.post(
          'https://expensemonitor.000webhostapp.com/user/displaybudget.php',
          body: map);
      print("getBudget>> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Budget> list = parsePhoto(response.body);
        return list;
      } else {
        throw List<Budget>();
      }
    } catch (e) {
      return List<Budget>();
    }
  }

  static List<Budget> parsePhoto(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Budget>((json) => Budget.fromJson(json)).toList();
  }

  static Future<List<Review>> getReview(String userid, String month) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      map["user_id"] = userid;
      map["month"] = month;
      final response = await http.post(
          "https://expensemonitor.000webhostapp.com/user/displayreview.php",
          body: map);
      print("getReview>> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Review> list = parsePhot(response.body);
        return list;
      } else {
        throw List<Review>();
      }
    } catch (e) {
      return List<Review>();
    }
  }

  static List<Review> parsePhot(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Review>((json) => Review.fromJson(json)).toList();
  }

  static Future<String> deleteExpenses(String empId) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _DELETE_EMP_ACTION;
      map["emp_id"] = empId;
      final response = await http.post(ROOT, body: map);
      print("deleteExpenses >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<List<Income>> getIncome(String userid) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      map["user_id"] = userid;
      final response = await http.post(ROOT, body: map);
      print("getIncome>> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Income> list = parsePho(response.body);
        return list;
      } else {
        throw List<Income>();
      }
    } catch (e) {
      return List<Income>();
    }
  }

  static List<Income> parsePho(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Expenses>((json) => Expenses.fromJson(json)).toList();
  }

  /*static Future<String> createTable() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _CREATE_TABLE;
      final response = await http.post(ROOT, body: map);
      print("createTable >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _ADD_EMP_ACTION;
      map["first_name"] = firstName;
      map["last_name"] = lastName;
      final response = await http.post(ROOT, body: map);
      print("addEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateEmployee(
      String empId, String firstName, String lastName) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _UPDATE_EMP_ACTION;
      map["emp_id"] = empId;
      map["first_name"] = firstName;
      map["last_name"] = lastName;
      final response = await http.post(ROOT, body: map);
      print("deleteEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteExpenses(String empId) async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _DELETE_EMP_ACTION;
      map["emp_id"] = empId;
      final response = await http.post(ROOT, body: map);
      print("deleteExpenses >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }*/
}
