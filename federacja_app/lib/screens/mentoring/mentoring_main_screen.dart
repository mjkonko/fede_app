import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entity/mentoring/mentoring_page_instance.dart';
import '../../utils/mentoring/mentoring_utils.dart';
import '../../utils/ui_utils.dart';
import 'mentoring_about_screen.dart';
import 'mentoring_links_screen.dart';

class MentoringPage extends StatefulWidget {
  const MentoringPage({Key? key}) : super(key: key);

  final String title = "Mentoring";

  @override
  State<MentoringPage> createState() => _MentoringPageState();
}

class _MentoringPageState extends State<MentoringPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                tabs: const <Widget>[
                  Tab(
                    text: "About Us",
                  ),
                  Tab(
                    text: "More",
                  )
                ]),
            widget.title),
        body: FutureBuilder<MentoringPageInstance>(
          future: MentoringUtils().fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                snapshot.error.toString();
              }
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              return TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Center(
                      child: MentoringPageAbout(
                          title: 'About the mentoring programmes',
                          page: snapshot.data)),
                  Center(
                      child: MentoringPageLinks(
                          title: "More",
                          email: snapshot.data!.email,
                          links: snapshot.data!.links))
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
