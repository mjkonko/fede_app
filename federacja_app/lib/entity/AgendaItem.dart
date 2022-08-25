class AgendaItem {
  final int id;
  final String name;
  final int venue;
  final int speaker;
  final String time;
  final String description;

  AgendaItem(
      {required this.id,
      required this.name,
      required this.venue,
      required this.speaker,
      required this.time,
      required this.description});

  factory AgendaItem.fromJson(Map<String, dynamic> json) {
    return AgendaItem(
        id: json['id'],
        name: json['name'],
        venue: json['venue'],
        speaker: json['speaker'],
        time: json['time'],
        description: json['description']);
  }
}
