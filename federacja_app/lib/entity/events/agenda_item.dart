class AgendaItem {
  final int id;
  final String name;
  String? venue;
  String? speaker;
  final String time;
  String? endTime;
  final String description;

  AgendaItem(
      {required this.id,
      required this.name,
      this.venue,
      this.speaker,
      required this.time,
      this.endTime,
      required this.description});

  factory AgendaItem.fromJson(Map<String, dynamic> json) {
    return AgendaItem(
        id: json['id'],
        name: json['name'],
        venue: json['venue'],
        speaker: json['speaker'],
        time: json['time'],
        endTime: json['endTime'],
        description: json['description']);
  }
}
