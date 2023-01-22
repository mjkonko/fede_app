import 'package:federacja_app/screens/polsocs/entity_screen/polsoc_main_screen.dart';
import 'package:federacja_app/utils/polsocs/polsocs_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entity/polsocs/polsoc_instance.dart';
import '../../utils/ui_utils.dart';

class PolSocsListPage extends StatefulWidget {
  const PolSocsListPage({Key? key}) : super(key: key);

  final String title = "Polish Societies";

  @override
  State<PolSocsListPage> createState() => _PolSocsListPageState();
}

class _PolSocsListPageState extends State<PolSocsListPage>
    with TickerProviderStateMixin {
  List<Widget> _tabs = <Tab>[];
  List<Widget> _generalWidgets = <Widget>[];
  late TabController _tabController;

  @override
  initState() {
    _tabs = PolSocsUtils().getRegionTabs();
    _tabController = getTabController();
    _generalWidgets = PolSocsUtils().getRegionWidgets();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UiUtils().getAppBar(
            context,
            TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).colorScheme.onPrimary,
                indicatorWeight: 1.5,
                indicatorSize: TabBarIndicatorSize.label,
                automaticIndicatorColorAdjustment: true,
                indicatorColor: const Color.fromRGBO(255, 255, 255, 1.0),
                tabs: _tabs),
            widget.title),
        body:
            TabBarView(controller: _tabController, children: _generalWidgets));
  }
}

class PolSocsList extends StatelessWidget {
  PolSocsList({Key? key, required this.list}) : super(key: key);

  late List<PolSocInstance> list;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 3.0, right: 3.0),
              child: ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  reverse: false,
                  cacheExtent: 80.0,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 5),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PolSocEntityPage(
                                        title: list[index].fullName,
                                        polsoc: list[index])),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    Theme.of(context).colorScheme.onBackground),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(0, 100)),
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                    const RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1.5,
                                            color: Color(0x88000000)),
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(25),
                                            right: Radius.circular(25))))),
                            child: Text(
                              list[index].fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.black),
                            )));
                  })))
    ]);
  }
}
