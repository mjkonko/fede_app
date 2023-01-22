import 'package:federacja_app/entity/save_eu/save_eu_page_instance.dart';
import 'package:federacja_app/utils/Instance.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../globals.dart';

class SaveEuUtils implements Instance {
  @override
  Future<SaveEUPageInstance> fetch() async {
    var client = await Globals().getPBClient();
    var records = await client
        .collection('fedeapp_page_save_eu_students')
        .getFullList(batch: 200, sort: '-created');

    if (records.isNotEmpty) {
      return parse(records);
    } else {
      throw Exception('Failed to load event items');
    }
  }

  @override
  SaveEUPageInstance parse(List<RecordModel> model) {
    var json = model.first.toJson();
    return SaveEUPageInstance.fromJson(json);
  }
}
