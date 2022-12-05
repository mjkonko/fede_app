import 'package:federacja_app/entity/save_eu_page_instance.dart';
import 'package:pocketbase/pocketbase.dart';

import '../globals.dart';

Future<SaveEUPageInstance> fetchSaveEUPage() async {
  var client = await Globals().getPBClient();
  var records = await client.records.getFullList(
      'fedeapp_page_save_eu_students',
      batch: 200,
      sort: '-created');

  if (records.isNotEmpty) {
    return parseRecord(records.first);
  } else {
    throw Exception('Failed to load event items');
  }
}

SaveEUPageInstance parseRecord(RecordModel model) {
  var json = model.toJson();
  return SaveEUPageInstance.fromJson(json);
}
