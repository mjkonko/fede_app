class AboutPageInstance {
  final String id;
  final String title;
  final String textTitle;
  final String text1;
  final String text2;
  final String links;
  final int photos;
  final String created;
  final String updated;

  AboutPageInstance(
      {required this.title,
      required this.id,
      required this.textTitle,
      required this.text1,
      required this.text2,
      required this.links,
      required this.photos,
      required this.created,
      required this.updated});

  factory AboutPageInstance.fromJson(Map<String, dynamic> json) {
    return AboutPageInstance(
        id: json['id'],
        title: json['title'],
        textTitle: json['textTitle'],
        text1: json['text1'],
        text2: json['text2'],
        links: json['links'],
        photos: json['photos'].length,
        created: json['created'],
        updated: json['updated']);
  }
}
