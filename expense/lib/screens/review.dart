class Review {
  String category;
  String estamount;
  String totalamount;

  Review({this.category, this.estamount, this.totalamount});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      category: json['cat_name'] as String,
      estamount: json['est_amount'] as String,
      totalamount: json['total_amount'] as String,
    );
  }
}
