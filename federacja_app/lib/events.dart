import 'package:flutter/material.dart';

import 'entity/AgendaItem.dart';
import 'entity/EventInstance.dart';

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
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        bottom: TabBar(
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
              text: "Contact us",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
              child: EventsAgenda(
            title: 'Agenda',
            agenda: [],
          )),
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
            email: widget.event.date,
            fb: widget.event.facebookPage,
            insta: widget.event.instaPage,
            linkedin: widget.event.linkedInPage,
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
  final List<AgendaItem> agenda;

  @override
  EventsAgendaState createState() => EventsAgendaState();
}

class EventsAgendaState extends State<EventsAgenda>
    with TickerProviderStateMixin {
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
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(widget.agenda.toString(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black87,
                      wordSpacing: 1,
                      overflow: TextOverflow.fade,
                      height: 1.5,
                    )),
          )
        ],
      ),
    ));
  }
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
      child: Column(
        children: [
          Text(widget.infoTitle,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black87,
                    wordSpacing: 1,
                    overflow: TextOverflow.fade,
                    height: 1.2,
                  )),
          Text(widget.infoSubtitle,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black87,
                    wordSpacing: 1,
                    overflow: TextOverflow.fade,
                    height: 1.5,
                  )),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(widget.infoText,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black87,
                      wordSpacing: 1,
                      overflow: TextOverflow.fade,
                      height: 1.5,
                    )),
          )
        ],
      ),
    ));
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
      required this.linkedin})
      : super(key: key);

  final String title;
  final String email;
  final String fb;
  final String insta;
  final String linkedin;

  @override
  EventsContactState createState() => EventsContactState();
}

class EventsContactState extends State<EventsContact>
    with TickerProviderStateMixin {
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
        children: [Text(widget.title)],
      ),
    ));
  }
}
