import 'package:federacja_app/entity/mentoring_page_instance.dart';
import 'package:pocketbase/pocketbase.dart';

import '../globals.dart';

Future<MentoringPageInstance> fetchMentoringPage() async {
  var client = await Globals().getPBClient();
  var records = await client.records
      .getFullList('fedeapp_page_mentoring', batch: 200, sort: '-created');

  if (records.isNotEmpty) {
    return parseRecord(records.first);
  } else {
    throw Exception('Failed to load event items');
  }
}

MentoringPageInstance parseRecord(RecordModel model) {
  var json = model.toJson();
  return MentoringPageInstance.fromJson(json);
}
