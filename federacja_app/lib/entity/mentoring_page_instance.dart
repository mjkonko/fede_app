class MentoringPageInstance {
  final String id;
  final String title;
  final String description;
  final String email;
  final String links;
  final String created;
  final String updated;

  MentoringPageInstance(
      {required this.title,
      required this.id,
      required this.description,
      required this.email,
      required this.links,
      required this.created,
      required this.updated});

  factory MentoringPageInstance.fromJson(Map<String, dynamic> json) {
    return MentoringPageInstance(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        email: json['email'],
        links: json['links'],
        created: json['created'],
        updated: json['updated']);
  }
}
