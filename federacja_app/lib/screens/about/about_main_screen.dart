import 'package:federacja_app/entity/about/about_page_instance.dart';
import 'package:federacja_app/utils/about/about_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/ui_utils.dart';
import 'about_committee_screen.dart';
import 'about_federation_screen.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  final String title = "About";

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
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
                  text: "Federation",
                ),
                Tab(
                  text: "Committee",
                )
              ],
            ),
            widget.title),
        body: FutureBuilder<AboutPageInstance>(
            future: AboutUtils().fetch(),
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
                        child: AboutFederation(
                      title: 'Federation',
                      page: snapshot.data,
                    )),
                    const Center(child: AboutCommittee(title: 'Committee'))
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
