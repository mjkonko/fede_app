import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entity/agenda_item.dart';
import '../entity/event_instance.dart';
import '../entity/event_link_instance.dart';
import '../globals.dart';
import '../utils/utils.dart';

/// Event operations page
class EventsPage extends StatefulWidget {
  const EventsPage({Key? key, required this.title, required this.event})
      : super(key: key);

  final String title;
  final EventInstance event;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Globals().getAppBar(
          context,
          TabBar(
              controller: _tabController,
              indicatorWeight: 1.5,
              indicatorSize: TabBarIndicatorSize.label,
              automaticIndicatorColorAdjustment: true,
              indicatorColor: const Color.fromRGBO(255, 255, 255, 1.0),
              tabs: const <Widget>[
                Tab(
                  text: "Agenda",
                ),
                Tab(
                  text: "Info",
                ),
                Tab(
                  text: "More",
                )
              ]),
          widget.title),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
              child:
                  EventsAgenda(title: 'Agenda', agenda: widget.event.agenda)),
          Center(
              child: EventsInfo(
            title: 'Info',
            infoTitle: widget.event.title,
            infoSubtitle: widget.event.subtitle,
            infoText: widget.event.description,
          )),
          Center(
              child: EventsContact(
            title: 'Contact',
            email: widget.event.email,
            fb: widget.event.facebookPage,
            insta: widget.event.instaPage,
            linkedin: widget.event.linkedInPage,
            links: widget.event.links,
          ))
        ],
      ),
    );
  }
}

/// Event operations page - agenda section
class EventsAgenda extends StatefulWidget {
  const EventsAgenda({Key? key, required this.title, required this.agenda})
      : super(key: key);

  final String title;
  final String agenda;

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

  List<AgendaItem> parseAgenda(String agenda) {
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
      child: ListView.builder(
        itemCount: agenda.length,
        shrinkWrap: true,
        cacheExtent: 75.0,
        itemBuilder: (context, index) {
          return ExpansionTile(
            tilePadding: const EdgeInsets.only(left: 25, right: 25),
            leading: Container(
              padding: const EdgeInsets.only(right: 12.0),
              decoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 0.75, color: Colors.red))),
              child: const Icon(Icons.event, color: Colors.black),
            ),
            title: Column(children: <Widget>[
              Text(
                agenda[index].name,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.black),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, top: 0.0, right: 0.0, bottom: 0.0),
                  child: parseDT(DateTime.parse(agenda[index].time)))
            ]),
            children: [makeListTile(agenda[index])],
          );
        },
      ),
    ));
  }

  Text parseDT(DateTime dt) => Text(
      "${DateFormat('dd/MM/yyyy').format(dt)} ${DateFormat('HH:mm').format(dt)}",
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w200,
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
                      const EdgeInsets.only(left: 14.0, top: 20.0, right: 14.0),
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
                      const EdgeInsets.only(left: 14.0, top: 0.0, right: 14.0),
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
          ],
        ),
      );
}

/// Event operations page - information section
class EventsInfo extends StatefulWidget {
  const EventsInfo(
      {Key? key,
      required this.title,
      required this.infoTitle,
      required this.infoSubtitle,
      required this.infoText})
      : super(key: key);

  final String title;
  final String infoTitle;
  final String infoSubtitle;
  final String infoText;

  @override
  EventsInfoState createState() => EventsInfoState();
}

class EventsInfoState extends State<EventsInfo> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Center(
                              child: Text(widget.infoTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        color: Colors.black87,
                                        wordSpacing: 1,
                                        overflow: TextOverflow.fade,
                                        height: 1.2,
                                      ))),
                          Text(widget.infoSubtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: Colors.black87,
                                    wordSpacing: 1,
                                    overflow: TextOverflow.fade,
                                    height: 2.5,
                                  )),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(widget.infoText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.black87,
                                      wordSpacing: 1,
                                      overflow: TextOverflow.fade,
                                      height: 1.5,
                                    )),
                          )
                        ],
                      ),
                    ))
              ],
            )));
  }
}

/// Event operations page - contact the team section
class EventsContact extends StatefulWidget {
  const EventsContact(
      {Key? key,
      required this.title,
      required this.email,
      required this.fb,
      required this.insta,
      required this.linkedin,
      this.links})
      : super(key: key);

  final String title;
  final String email;
  final String fb;
  final String insta;
  final String linkedin;
  final String? links;

  @override
  EventsContactState createState() => EventsContactState();
}

class EventsContactState extends State<EventsContact>
    with TickerProviderStateMixin {
  late final List<EventLinkInstance> links;
  var utils = Utils();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: Text("Contact the organisers",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.black87,
                      wordSpacing: 1,
                      overflow: TextOverflow.fade,
                      height: 1.2,
                    )),
          ),
          Center(
              child: ButtonBar(
            mainAxisSize: MainAxisSize.min,
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text('Email'),
                onPressed: () {
                  utils.sendEmail(email: widget.email);
                },
              ),
              TextButton(
                child: const Text('Facebook'),
                onPressed: () {
                  utils.launchInBrowser(widget.fb);
                },
              ),
              TextButton(
                child: const Text('Instagram'),
                onPressed: () {
                  utils.launchInBrowser(widget.insta);
                },
              ),
              TextButton(
                child: const Text('LinkedIn'),
                onPressed: () {
                  utils.launchInBrowser(widget.linkedin);
                },
              ),
            ],
          )),
          utils.returnLinksWidget(widget.links, context)
        ],
      ),
    ));
  }
}
