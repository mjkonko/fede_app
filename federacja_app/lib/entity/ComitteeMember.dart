import 'package:pocketbase/pocketbase.dart';

class CommitteeMember {
  final String id;
  final String name;
  final String email;
  final String position;
  final String linkedin;
  final String created;
  final String updated;

  CommitteeMember(
      {required this.id,
      required this.name,
      required this.email,
      required this.position,
      required this.linkedin,
      required this.created,
      required this.updated});

  factory CommitteeMember.fromJson(Map<String, dynamic> json) {
    return CommitteeMember(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        position: json['position'],
        linkedin: json['linkedin'],
        created: json['created'],
        updated: json['updated']);
  }

  factory CommitteeMember.fromRecordModel(RecordModel model) {
    return CommitteeMember.fromJson(model.toJson());
  }
}
