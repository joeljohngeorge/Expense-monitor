class Expenses {
  String description;
  String amount;
  String date;

  Expenses({this.description, this.amount, this.date});

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return Expenses(
      description: json['expense_description'] as String,
      amount: json['amount_spent'] as String,
      date: json['expense_date'] as String,
    );
  }
}
