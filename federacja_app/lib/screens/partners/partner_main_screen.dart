import 'package:federacja_app/screens/partners/partner_about_screen.dart';
import 'package:federacja_app/screens/partners/partner_links_screen.dart';
import 'package:flutter/material.dart';

import '../../entity/partners/partner_instance.dart';
import '../../utils/ui_utils.dart';

class PartnerPage extends StatefulWidget {
  const PartnerPage({Key? key, required this.title, required this.partner})
      : super(key: key);

  final String title;
  final PartnerInstance partner;

  @override
  State<PartnerPage> createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage>
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
          widget.partner.fullName),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
              child:
                  PartnerPageAbout(title: 'About Us', partner: widget.partner)),
          Center(
              child: PartnerPageLinks(
                  title: 'More',
                  email: widget.partner.email,
                  links: widget.partner.links))
        ],
      ),
    );
  }
}
