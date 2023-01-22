import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../entity/about/committee_member.dart';
import '../../globals.dart';
import '../../utils/global_utils.dart';

class AboutCommittee extends StatefulWidget {
  const AboutCommittee({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  AboutCommitteeState createState() => AboutCommitteeState();
}

class AboutCommitteeState extends State<AboutCommittee>
    with TickerProviderStateMixin {
  Future<List<CommitteeMember>> fetchCommittee() async {
    var client = await Globals().getPBClient();
    var records = await client
        .collection('committee')
        .getFullList(batch: 200, sort: '+order');

    if (records.isNotEmpty) {
      return parseCommittee(records);
    } else {
      throw Exception('Failed to load committee data');
    }
  }

  List<CommitteeMember> parseCommittee(List<RecordModel> records) {
    List<CommitteeMember> list = records
        .map<CommitteeMember>((json) => CommitteeMember.fromRecordModel(json))
        .toList();

    return list;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<CommitteeMember>>(
      future: fetchCommittee(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            snapshot.error.toString();
          }
          return const Center(child: Text('An error has occurred!'));
        } else if (snapshot.hasData) {
          return CommitteeList(list: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}

class CommitteeList extends StatelessWidget {
  const CommitteeList({Key? key, required this.list}) : super(key: key);

  final List<CommitteeMember> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: list.length,
        shrinkWrap: true,
        reverse: false,
        cacheExtent: 75.0,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: [
              ListTile(
                  isThreeLine: false,
                  style: ListTileStyle.list,
                  contentPadding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10),
                  subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Center(child: Text(list[index].name))),
                  title: Center(
                      child: Text(list[index].position,
                          softWrap: true, textAlign: TextAlign.center))),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
                indent: 12.0,
                endIndent: 12.0,
              ),
              Center(
                  child: ButtonBar(
                overflowDirection: VerticalDirection.down,
                children: <Widget>[
                  TextButton(
                    child: const Text('Email'),
                    onPressed: () {
                      GlobalUtils().sendEmail(email: list[index].email);
                    },
                  ),
                  TextButton(
                    child: const Text('LinkedIn'),
                    onPressed: () {
                      GlobalUtils().launchInBrowser(list[index].linkedin);
                    },
                  ),
                ],
              )),
            ],
          ));
        });
  }
}
