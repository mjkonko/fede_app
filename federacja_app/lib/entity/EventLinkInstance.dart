class EventLinkInstance {
  final int id;
  final String link;
  final String title;

  EventLinkInstance(
      {required this.id, required this.link, required this.title});

  factory EventLinkInstance.fromJson(Map<String, dynamic> json) {
    return EventLinkInstance(
        id: json['id'], link: json['link'], title: json['title']);
  }
}
