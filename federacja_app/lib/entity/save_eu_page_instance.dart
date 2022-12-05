class SaveEUPageInstance {
  final String id;
  final String title;
  final String description;
  final String email;
  final String logo;
  final String links;
  final String created;
  final String updated;

  SaveEUPageInstance(
      {required this.title,
      required this.id,
      required this.description,
      required this.email,
      required this.logo,
      required this.links,
      required this.created,
      required this.updated});

  factory SaveEUPageInstance.fromJson(Map<String, dynamic> json) {
    return SaveEUPageInstance(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        email: json['email'],
        logo: json['logo'],
        links: json['links'],
        created: json['created'],
        updated: json['updated']);
  }
}
