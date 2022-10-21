class AgendaItem {
  final int id;
  final String name;
  String? venue;
  final String time;
  final String description;

  AgendaItem(
      {required this.id,
      required this.name,
      this.venue,
      required this.time,
      required this.description});

  factory AgendaItem.fromJson(Map<String, dynamic> json) {
    return AgendaItem(
        id: json['id'],
        name: json['name'],
        venue: json['venue'],
        time: json['time'],
        description: json['description']);
  }
}
