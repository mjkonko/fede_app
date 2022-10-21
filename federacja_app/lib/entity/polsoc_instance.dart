import 'package:pocketbase/pocketbase.dart';

class PolSocInstance {
  final String id;
  final String fullName;
  final String name;
  final String university;
  final String description;
  String? facebook;
  String? instagram;
  String? linkedin;
  String? email;
  final String address;
  String? geoPosition;
  final String region;
  String? logo;
  final bool verified;
  final bool active;
  String? links;
  final String created;
  final String updated;

  PolSocInstance(
      {required this.id,
      required this.fullName,
      required this.name,
      required this.university,
      required this.description,
      this.facebook,
      this.instagram,
      this.linkedin,
      this.email,
      required this.address,
      this.geoPosition,
      required this.region,
      this.logo,
      required this.verified,
      required this.active,
      this.links,
      required this.created,
      required this.updated});

  factory PolSocInstance.fromJson(Map<String, dynamic> json) {
    return PolSocInstance(
        id: json['id'],
        fullName: json['full_name'],
        name: json['name'],
        university: json['university'],
        description: json['description'],
        facebook: json['facebook'],
        instagram: json['instagram'],
        linkedin: json['linkedin'],
        email: json['email'],
        address: json['address'],
        geoPosition: json['geoPosition'],
        region: json['region'],
        logo: json['logo'],
        verified: json['verified'],
        active: json['active'],
        links: json['links'],
        created: json['created'],
        updated: json['updated']);
  }

  factory PolSocInstance.fromRecordModel(RecordModel model) {
    return PolSocInstance.fromJson(model.toJson());
  }
}
