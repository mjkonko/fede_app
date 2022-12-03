import 'package:pocketbase/pocketbase.dart';

class PartnerInstance {
  final String id;
  final String fullName;
  final String shortName;
  final String description;
  final String email;
  String? address;
  String? geoPosition;
  String? logo;
  final bool verified;
  final bool active;
  String? links;
  final String created;
  final String updated;

  PartnerInstance(
      {required this.id,
      required this.fullName,
      required this.shortName,
      required this.description,
      required this.email,
      this.address,
      this.geoPosition,
      this.logo,
      required this.verified,
      required this.active,
      this.links,
      required this.created,
      required this.updated});

  factory PartnerInstance.fromJson(Map<String, dynamic> json) {
    return PartnerInstance(
        id: json['id'],
        fullName: json['full_name'],
        shortName: json['shortName'],
        description: json['description'],
        email: json['email'],
        address: json['address'],
        geoPosition: json['geoPosition'],
        logo: json['logo'],
        verified: json['verified'],
        active: json['active'],
        links: json['links'],
        created: json['created'],
        updated: json['updated']);
  }

  factory PartnerInstance.fromRecordModel(RecordModel model) {
    return PartnerInstance.fromJson(model.toJson());
  }
}
