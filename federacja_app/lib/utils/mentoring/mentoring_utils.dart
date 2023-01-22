import 'package:federacja_app/entity/mentoring/mentoring_page_instance.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../globals.dart';
import '../Instance.dart';

class MentoringUtils implements Instance {
  @override
  Future<MentoringPageInstance> fetch() async {
    var client = await Globals().getPBClient();
    var records = await client
        .collection('fedeapp_page_mentoring')
        .getFullList(batch: 200, sort: '-created');

    if (records.isNotEmpty) {
      return parse(records);
    } else {
      throw Exception('Failed to load event items');
    }
  }

  @override
  MentoringPageInstance parse(List<RecordModel> model) {
    var json = model.first.toJson();
    return MentoringPageInstance.fromJson(json);
  }
}
