import 'package:pocketbase/pocketbase.dart';

class EventInstance {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String date;
  final String facebookPage;
  final String instaPage;
  final String linkedInPage;
  final String agenda;
  String? links;
  final String created;
  final String updated;

  EventInstance(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.date,
      required this.facebookPage,
      required this.instaPage,
      required this.linkedInPage,
      required this.agenda,
      this.links,
      required this.created,
      required this.updated});

  factory EventInstance.fromJson(Map<String, dynamic> json) {
    return EventInstance(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        description: json['description'],
        date: json['date'],
        facebookPage: json['facebookpage'],
        instaPage: json['instapage'],
        linkedInPage: json['linkedinpage'],
        agenda: json['agenda'],
        links: json['links'],
        created: json['created'],
        updated: json['updated']);
  }

  factory EventInstance.fromRecordModel(RecordModel model) {
    return EventInstance.fromJson(model.toJson());
  }
}
