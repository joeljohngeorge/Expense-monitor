class Budget {
  String category;
  String percent;

  Budget({this.category, this.percent});

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      category: json['category'] as String,
      percent: json['percet'] as String,
    );
  }
}
