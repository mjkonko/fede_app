import 'package:federacja_app/utils/Instance.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../entity/about/committee_member.dart';
import '../../../globals.dart';

class CommitteeUtils implements Instance {
  @override
  Future<List<CommitteeMember>> fetch() async {
    var client = await Globals().getPBClient();
    var records = await client
        .collection('committee')
        .getFullList(batch: 200, sort: '+order');

    if (records.isNotEmpty) {
      return parse(records);
    } else {
      throw Exception('Failed to load committee data');
    }
  }

  @override
  List<CommitteeMember> parse(List<RecordModel> records) {
    List<CommitteeMember> list = records
        .map<CommitteeMember>((json) => CommitteeMember.fromRecordModel(json))
        .toList();

    return list;
  }
}
