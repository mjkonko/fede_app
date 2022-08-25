class NewsItem {
  final int id;
  final String date;
  final String title;
  final String text;

  NewsItem({
    required this.id,
    required this.date,
    required this.title,
    required this.text,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
        id: json['id'],
        date: json['date'],
        title: json['title'],
        text: json['text']);
  }
}
