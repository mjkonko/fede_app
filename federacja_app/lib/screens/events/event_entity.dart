import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entity/agenda_item.dart';
import '../../entity/event_instance.dart';
import '../../entity/event_link_instance.dart';
import '../../globals.dart';
import '../../utils/utils.dart';

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
  List<Widget> _tabs = <Tab>[];
  List<Widget> _generalWidgets = <Widget>[];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabs = getHeaderTabs();
    _tabController = getTabController();
    _generalWidgets = getTabs(widget);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  List<Widget> getHeaderTabs() {
    List<Widget> list = [];

    if (widget.event.agenda != "[]") {
      list.add(const Tab(
        text: "Agenda",
      ));
    }

    List<Widget> defaultTabs = [
      const Tab(
        text: "Info",
      ),
      const Tab(
        text: "More",
      )
    ];

    list.addAll(defaultTabs);
    return list;
  }

  List<Widget> getTabs(EventsPage widget) {
    List<Widget> list = [];

    if (widget.event.agenda != "[]") {
      list.add(Center(
          child: EventsAgenda(title: 'Agenda', agenda: widget.event.agenda)));
    }

    List<Widget> defaultTabs = [
      Center(
          child: EventsInfo(
        id: widget.event.id,
        title: 'Info',
        infoTitle: widget.event.title,
        infoSubtitle: widget.event.subtitle,
        infoText: widget.event.description,
        photosNumber: widget.event.photos,
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
    ];

    list.addAll(defaultTabs);
    return list;
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
              tabs: _tabs),
          widget.title),
      body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: _generalWidgets),
    );
  }
}

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
              tilePadding: const EdgeInsets.only(left: 25, right: 25),
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

/// Event operations page - information section
class EventsInfo extends StatefulWidget {
  const EventsInfo(
      {Key? key,
      required this.id,
      required this.title,
      required this.infoTitle,
      required this.infoSubtitle,
      required this.infoText,
      required this.photosNumber})
      : super(key: key);

  final String id;
  final String title;
  final String infoTitle;
  final String infoSubtitle;
  final String infoText;
  final int photosNumber;

  @override
  EventsInfoState createState() => EventsInfoState();
}

class EventsInfoState extends State<EventsInfo> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Column returnPhotosIfAvailable() {
    return Column(
      children: getPhotos(),
    );
  }

  List<Widget> getPhotos() {
    List<Widget> photosWidgets = [];

    for (int i = 1; i < widget.photosNumber; i++) {
      photosWidgets.add(FutureBuilder(
          future: Globals().getFileUrl('event', widget.id, i, 'photos'),
          builder: (context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Column(children: [
                    Text(
                      "Couldn't load the picture ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    )
                  ]);
                } else {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 12.5),
                    child: CachedNetworkImage(
                        width: 600,
                        imageUrl: snapshot.data.toString(),
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) => Container()),
                  ));
                }
            }
          }));
    }
    return photosWidgets;
  }

  Text getTextTitleWhenError() {
    return Text(widget.infoTitle,
        softWrap: true,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.black87,
              wordSpacing: 1,
              overflow: TextOverflow.fade,
              height: 1.2,
            ));
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
                              child: FutureBuilder(
                                  future: Globals().getFileUrl('event',
                                      widget.id, 0, 'photos'), // get logo
                                  builder: (context,
                                      AsyncSnapshot<String> snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
                                      case ConnectionState.active:
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          print(snapshot.error.toString());
                                          return Column(children: [
                                            getTextTitleWhenError()
                                          ]);
                                        } else {
                                          return Center(
                                            child: CachedNetworkImage(
                                              width: 240,
                                              imageUrl:
                                                  snapshot.data.toString(),
                                              placeholder: (context, url) =>
                                                  Column(
                                                children: [
                                                  Text(widget.infoTitle,
                                                      softWrap: true,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                            color:
                                                                Colors.black87,
                                                            wordSpacing: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            height: 1.2,
                                                          )),
                                                ],
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      getTextTitleWhenError(),
                                            ),
                                          );
                                        }
                                    }
                                  })),
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
                          ),
                          returnPhotosIfAvailable()
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
