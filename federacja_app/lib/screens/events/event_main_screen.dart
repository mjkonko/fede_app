import 'package:flutter/material.dart';

import '../../entity/events/event_instance.dart';
import '../../utils/ui_utils.dart';
import 'event_agenda_screen.dart';
import 'event_info_screen.dart';
import 'event_links_screen.dart';

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

    if (hasAgenda()) {
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

    if (hasAgenda()) {
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
          child: EventsLinks(
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

  bool hasAgenda() {
    return widget.event.agenda != "[]";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiUtils().getAppBar(
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
