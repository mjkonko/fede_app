import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../entity/about/comittee_member.dart';
import '../../globals.dart';
import '../../utils/global_utils.dart';
import '../../utils/ui_utils.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  final String title = "About";

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiUtils().getAppBar(
          context,
          TabBar(
            controller: _tabController,
            indicatorWeight: 1.5,
            indicatorSize: TabBarIndicatorSize.label,
            automaticIndicatorColorAdjustment: true,
            indicatorColor: const Color.fromRGBO(255, 255, 255, 1.0),
            tabs: const <Widget>[
              Tab(
                text: "Federation",
              ),
              Tab(
                text: "Committee",
              )
            ],
          ),
          widget.title),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          Center(child: AboutFederation(title: 'Federation')),
          Center(child: AboutCommittee(title: 'Committee'))
        ],
      ),
    );
  }
}

class AboutFederation extends StatefulWidget {
  const AboutFederation({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  AboutFederationState createState() => AboutFederationState();
}

class AboutFederationState extends State<AboutFederation>
    with TickerProviderStateMixin {
  final String textTitle = "Our mission";
  final String textParagraph1 = "To foster cooperation between Polish student "
      "Societies in the UK by providing guidance to local and nationwide initiatives "
      "and representing the interest of Polish students in the UK on the national "
      "and international level.";
  final String textParagraph2 =
      "There are currently tens of thousands Polish students in the UK. "
      "Through the establishment of Polish Societies at universities across the country, "
      "they create small local communities organising celebrations, social meetings,"
      "and networking opportunities. The Federation serves as an integrating body providing support and knowledge,"
      "helping consecutive generations continue the work of PolSocs."
      "It is the primary body responsible for defending the interests"
      "of Polish Students in the United Kingdom. Through flagship projects such "
      "as annual Congress of Polish Student Societies, international pro-European"
      "students campaign SaveEU Students, and a mentoring scheme EmpowerPL run in"
      "cooperation with The Boston Consulting Group, The Federation continues to grow"
      "and flourish, promoting Polish culture and influence on international affairs.";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Flex(direction: Axis.vertical, children: [
              Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text(textTitle,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      color: Colors.black87,
                                      wordSpacing: 1,
                                      overflow: TextOverflow.fade,
                                      height: 1.2,
                                    )),
                        Text(textParagraph1,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.black87,
                                      wordSpacing: 1,
                                      overflow: TextOverflow.fade,
                                      height: 1.5,
                                    )),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(textParagraph2,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Colors.black87,
                                    wordSpacing: 1,
                                    overflow: TextOverflow.fade,
                                    height: 1.5,
                                  )),
                        )
                      ],
                    ),
                  ))
            ])));
  }
}

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
    var utils = GlobalUtils();

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
                      utils.sendEmail(email: list[index].email);
                    },
                  ),
                  TextButton(
                    child: const Text('LinkedIn'),
                    onPressed: () {
                      utils.launchInBrowser(list[index].linkedin);
                    },
                  ),
                ],
              )),
            ],
          ));
        });
  }
}
