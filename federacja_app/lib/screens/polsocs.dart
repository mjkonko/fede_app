import 'package:federacja_app/entity/PolSocInstance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../globals.dart';

class PolSocsPage extends StatefulWidget {
  const PolSocsPage({Key? key}) : super(key: key);

  final String title = "PolSocs";

  @override
  State<PolSocsPage> createState() => _PolSocsPageState();
}

class _PolSocsPageState extends State<PolSocsPage>
    with TickerProviderStateMixin {
  List<Widget> _tabs = <Tab>[];
  List<Widget> _generalWidgets = <Widget>[];
  late TabController _tabController;

  @override
  initState() {
    _tabs = getRegionTabs();
    _tabController = getTabController();
    _generalWidgets = getRegionWidgets();
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
        appBar: Globals().getAppBar(
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
                    return TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.onBackground),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                const RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.9375,
                                        color: Color(0x88888888)),
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(25),
                                        right: Radius.circular(25))))),
                        child: Text(
                          list[index].fullName,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Colors.black),
                        ));
                  })))
    ]);
  }
}

List<Tab> getRegionTabs() {
  List<Tab> tabs = [];

  for (var region in Globals().regions) {
    tabs.add(Tab(
      text: region,
    ));
  }

  return tabs;
}

List<Widget> getRegionWidgets() {
  List<Widget> widgets = [];

  for (var region in Globals().regions) {
    widgets.add(generateRegionWidget(region));
  }

  return widgets;
}

Widget generateRegionWidget(String region) {
  return FutureBuilder<List<PolSocInstance>>(
    future: fetchPolSocs(region),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        if (kDebugMode) {
          snapshot.error.toString();
        }
        return Center(child: Text('An error has occurred! ${snapshot.error}'));
      } else if (snapshot.hasData) {
        return PolSocsList(list: snapshot.data!);
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Future<List<PolSocInstance>> fetchPolSocs(String region) async {
  // alternatively you can also fetch all records at once via getFullList:
  final records = await Globals().getPBClient().records.getFullList('polsocs',
      batch: 200,
      sort: '-created',
      filter: 'region ~"$region"&&active=true&&verified=true');

  return parsePolSocs(records);
}

List<PolSocInstance> parsePolSocs(List<RecordModel> records) {
  List<PolSocInstance> list = records
      .map<PolSocInstance>((json) => PolSocInstance.fromRecordModel(json))
      .toList();
  return list;
}
