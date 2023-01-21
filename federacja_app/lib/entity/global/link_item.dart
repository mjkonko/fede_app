class LinkItem {
  final int id;
  final String link;
  final String title;

  LinkItem({required this.id, required this.link, required this.title});

  factory LinkItem.fromJson(Map<String, dynamic> json) {
    return LinkItem(id: json['id'], link: json['link'], title: json['title']);
  }
}
