class Income {
  String title;
  String text;

  Income(this.title, this.text);

  Income.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['sub'];
  }
}
