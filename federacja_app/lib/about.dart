import 'dart:convert';

import 'package:federacja_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        bottom: TabBar(
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
      ),
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
      child: Column(
        children: [
          Text(textTitle,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black87,
                    wordSpacing: 1,
                    overflow: TextOverflow.fade,
                    height: 1.2,
                  )),
          Text(textParagraph1,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black87,
                    wordSpacing: 1,
                    overflow: TextOverflow.fade,
                    height: 1.5,
                  )),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(textParagraph2,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black87,
                      wordSpacing: 1,
                      overflow: TextOverflow.fade,
                      height: 1.5,
                    )),
          )
        ],
      ),
    ));
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
  var _items = [];
  var utils = Utils();

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('lib/assets/committee.json');
    final data = await json.decode(response);

    setState(() {
      _items = data["list"];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    readJson();

    return Scaffold(
        body: _items.isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                            //scrollDirection: Axis.horizontal,
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        isThreeLine: false,
                                        style: ListTileStyle.list,
                                        contentPadding: const EdgeInsets.only(
                                            left: 16.0, right: 10.0),
                                        subtitle: Text(_items[index]["name"]),
                                        title: Text(_items[index]["position"]),
                                      ),
                                      ButtonBar(
                                        children: <Widget>[
                                          TextButton(
                                            child: const Text('Email'),
                                            onPressed: () {
                                              utils.sendEmail(
                                                  email: _items[index]
                                                      ["email"]);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('LinkedIn'),
                                            onPressed: () {
                                              utils.launchInBrowser(
                                                  _items[index]["linkedin"]);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ));
                            }))
                  ])
            : Container(
                child: const Center(
                    child: Text(
                        'Problem loading section, please contact the dev team.'))));
  }
}
