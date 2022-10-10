import 'dart:convert';

import 'package:federacja_app/entity/EventInstance.dart';
import 'package:federacja_app/events.dart';
import 'package:federacja_app/tileutils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'globals.dart';

class EventUtils extends StatefulWidget {
  const EventUtils({Key? key}) : super(key: key);

  @override
  EventState createState() => EventState();
}

class EventState extends State<EventUtils> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EventInstance>>(
      future: fetchEvents(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            snapshot.error.toString();
          }
          return const Center(child: Text('There are no events available'));
        } else if (snapshot.hasData) {
          return EventList(
            list: snapshot.data!,
            context: context,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class EventList extends StatelessWidget {
  const EventList({Key? key, required this.list, required BuildContext context})
      : super(key: key);
  final List<EventInstance> list;

  Tile makeTile(BuildContext context, EventInstance item) {
    return Tile(
        () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventsPage(
                          title: item.title,
                          event: EventInstance(
                              id: item.id,
                              title: item.title,
                              subtitle: item.subtitle,
                              description: item.description,
                              date: item.date,
                              facebookPage: item.facebookPage,
                              instaPage: item.instaPage,
                              linkedInPage: item.linkedInPage,
                              agenda: item.agenda
                              //'[{"id": 1, "name": "Test", "venue": "Venue", "time": "2022-09-25T12:15:23.701Z", "description": "desc"},{"id": 2, "name": "Test", "venue": "Venue", "time": "2022-09-25T12:15:23.701Z", "description": "desc"}]',
                              ),
                        )),
              )
            },
        item.title,
        Theme.of(context).colorScheme.background);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        padding: const EdgeInsets.all(0.5),
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 0.5,
        crossAxisSpacing: 0.5,
        shrinkWrap: true,
        children: generateTiles(context));
  }

  List<Widget> generateTiles(BuildContext context) {
    List<Tile> tiles = [];
    for (int i = 0; i < list.length; i++) {
      tiles.add(makeTile(context, list[i]));
    }

    if (tiles.length.isOdd) {
      tiles.add(ImageLogoTile(
          () => {}, 'Placeholder', Theme.of(context).colorScheme.secondary));
    }

    return tiles;
  }
}

Future<List<EventInstance>> fetchEvents(http.Client client) async {
  final response = await client.get(Uri.parse(Globals().getEventsUrl()),
      headers: {'Accept': 'application/json; charset=UTF-8'});
  if (response.statusCode == 200) {
    return compute(parseEvent, response.bodyBytes.toList());
  } else {
    throw Exception('Failed to load news items');
  }
}

List<EventInstance> parseEvent(List<int> responseBytes) {
  final parsed =
      jsonDecode(utf8.decode(responseBytes)).cast<Map<String, dynamic>>();
  List<EventInstance> list = parsed
      .map<EventInstance>((json) => EventInstance.fromJson(json))
      .toList();
  list.sort((item1, item2) => item1.id.compareTo(item2.id));
  return list;
}
