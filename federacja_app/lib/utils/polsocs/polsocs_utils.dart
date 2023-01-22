import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../entity/polsocs/polsoc_instance.dart';
import '../../globals.dart';
import '../../screens/polsocs/polsocs_list_screen.dart';

class PolSocsUtils {
  Future<List<PolSocInstance>> fetch(String region) async {
    // alternatively you can also fetch all records at once via getFullList:
    var client = await Globals().getPBClient();
    var records = await client.collection('polsocs').getFullList(
        batch: 200,
        sort: '-created',
        filter: 'region ~"$region"&&active=true&&verified=true');

    return parse(records);
  }

  List<PolSocInstance> parse(List<RecordModel> records) {
    List<PolSocInstance> list = records
        .map<PolSocInstance>((json) => PolSocInstance.fromRecordModel(json))
        .toList();
    return list;
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
      future: fetch(region),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            snapshot.error.toString();
          }
          return Center(
              child: Text('An error has occurred! ${snapshot.error}'));
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
}
