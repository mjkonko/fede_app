import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entity/events/agenda_item.dart';

/// Event operations page - agenda section
class EventsAgenda extends StatefulWidget {
  EventsAgenda({Key? key, required this.title, this.agenda}) : super(key: key);

  final String title;
  String? agenda;

  @override
  EventsAgendaState createState() => EventsAgendaState();
}

class EventsAgendaState extends State<EventsAgenda>
    with TickerProviderStateMixin {
  late final List<AgendaItem> agenda;

  @override
  void initState() {
    super.initState();
    agenda = parseAgenda(widget.agenda);
  }

  List<AgendaItem> parseAgenda(String? agenda) {
    if (agenda == null) {
      return [];
    }

    final parsed = json.decode(agenda).cast<Map<String, dynamic>>();

    List<AgendaItem> list =
        parsed.map<AgendaItem>((json) => AgendaItem.fromJson(json)).toList();
    list.sort((item1, item2) => item1.id.compareTo(item2.id));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(7.5),
      child: getView(),
    ));
  }

  Widget getView() {
    if (agenda.isEmpty) {
      return Center(
          child: Text(
        "There is no agenda available now.",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.black),
      ));
    }

    return ListView.builder(
      itemCount: agenda.length,
      shrinkWrap: true,
      cacheExtent: 75.0,
      itemBuilder: (context, index) {
        return ListTileTheme(
            contentPadding: const EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 12.5,
            minLeadingWidth: 5,
            child: ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 25, right: 12.5),
              leading: Container(
                padding: const EdgeInsets.only(right: 12.5),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 0.75, color: Colors.red))),
                child: const Icon(Icons.event, color: Colors.black),
              ),
              title: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, top: 5.0, right: 5.0, bottom: 7.0),
                  child: Text(
                    agenda[index].name,
                    softWrap: true,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 0.0, right: 0.0, bottom: 0.0),
                    child: generateEventTimeRow(agenda[index], context))
              ]),
              children: [makeListTile(agenda[index])],
            ));
      },
    );
  }

  Widget generateEventTimeRow(AgendaItem item, BuildContext context) {
    List<Widget> list = [];

    list.add(parseDT(DateTime.parse(item.time)));
    list.add(Text(" - ",
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 12,
            letterSpacing: 1)));

    if (item.endTime == null) {
      list.add(Text("no end time",
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12,
              letterSpacing: 1)));
      return Row(children: list);
    }

    list.add(parseDT(DateTime.parse(item.endTime!)));
    return Row(children: list);
  }

  Text parseDT(DateTime dt) => Text(
      "${DateFormat('dd/MM/yyyy').format(dt)} ${DateFormat('HH:mm').format(dt)}",
      softWrap: true,
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w300,
          fontSize: 12,
          letterSpacing: 1));

  ListTile makeListTile(AgendaItem item) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        subtitle: Column(
          children: <Widget>[
            Row(children: [
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                  child: Text(item.description,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black)),
                ),
              ),
            ]),
            const Divider(
              color: Colors.black45,
              height: 30,
              thickness: 0.5,
              indent: 10,
              endIndent: 10,
            ),
            Row(children: [
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 0.0, right: 14.0),
                  child: Text(
                      "Venue: ${item.venue ?? "Not available for this event"}",
                      softWrap: true,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          letterSpacing: 1)),
                ),
              ),
            ]),
            Row(children: [
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 0.0, right: 14.0),
                  child: Text(
                      "Led by: ${item.speaker ?? "Not available for this event"}",
                      softWrap: true,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          letterSpacing: 1)),
                ),
              ),
            ]),
          ],
        ),
      );
}
