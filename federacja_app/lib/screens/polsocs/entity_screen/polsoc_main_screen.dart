import 'package:federacja_app/entity/polsocs/polsoc_instance.dart';
import 'package:federacja_app/screens/polsocs/entity_screen/polsoc_about_screen.dart';
import 'package:federacja_app/screens/polsocs/entity_screen/polsoc_links_screen.dart';
import 'package:flutter/material.dart';

import '../../../utils/ui_utils.dart';

class PolSocEntityPage extends StatefulWidget {
  const PolSocEntityPage({Key? key, required this.title, required this.polsoc})
      : super(key: key);

  final String title;
  final PolSocInstance polsoc;

  @override
  State<PolSocEntityPage> createState() => _PolSocEntityPageState();
}

class _PolSocEntityPageState extends State<PolSocEntityPage>
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
          widget.polsoc.name),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
              child:
                  PolSocEntityAbout(title: 'About Us', polsoc: widget.polsoc)),
          Center(
              child: PolSocEntityLinks(
                  title: 'More',
                  email: widget.polsoc.email,
                  links: widget.polsoc.links))
        ],
      ),
    );
  }
}
