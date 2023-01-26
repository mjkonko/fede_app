import 'package:federacja_app/entity/about/about_page_instance.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../globals.dart';
import '../Instance.dart';

class AboutUtils implements Instance {
  @override
  Future<AboutPageInstance> fetch() async {
    var client = await Globals().getPBClient();
    var records = await client
        .collection('fedeapp_page_about')
        .getFullList(batch: 200, sort: '-created');

    if (records.isNotEmpty) {
      return parse(records);
    } else {
      throw Exception('Failed to load event items');
    }
  }

  @override
  AboutPageInstance parse(List<RecordModel> model) {
    var json = model.first.toJson();
    return AboutPageInstance.fromJson(json);
  }
}
