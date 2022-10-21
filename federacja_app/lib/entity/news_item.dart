import 'package:pocketbase/pocketbase.dart';

class NewsItem {
  final String id;
  final String date;
  final String title;
  final String text;
  final String author;
  final String created;
  final String updated;

  NewsItem(
      {required this.id,
      required this.date,
      required this.title,
      required this.text,
      required this.author,
      required this.created,
      required this.updated});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
        id: json['id'],
        date: json['date'],
        title: json['title'],
        text: json['text'],
        author: json['author'],
        created: json['created'],
        updated: json['updated']);
  }

  factory NewsItem.fromRecordModel(RecordModel model) {
    return NewsItem.fromJson(model.toJson());
  }
}
