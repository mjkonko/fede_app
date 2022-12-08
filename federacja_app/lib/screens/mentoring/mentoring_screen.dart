import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entity/event_link_instance.dart';
import '../../entity/mentoring_page_instance.dart';
import '../../globals.dart';
import '../../utils/mentoring_utils.dart';
import '../../utils/utils.dart';

class MentoringPage extends StatefulWidget {
  MentoringPage({Key? key}) : super(key: key);

  final String title = "MentoringPage";

  @override
  State<MentoringPage> createState() => _MentoringPageState();
}

class _MentoringPageState extends State<MentoringPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Globals().getAppBar(
            context,
            TabBar(
                controller: _tabController,
                indicatorWeight: 1.5,
                indicatorSize: TabBarIndicatorSize.label,
                automaticIndicatorColorAdjustment: true,
                indicatorColor: const Color.fromRGBO(255, 255, 255, 1.0),
                tabs: const <Widget>[
                  Tab(
                    text: "About Us",
                  ),
                  Tab(
                    text: "More",
                  )
                ]),
            widget.title),
        body: FutureBuilder<MentoringPageInstance>(
          future: fetchMentoringPage(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                snapshot.error.toString();
              }
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              return TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Center(
                      child: MentoringPageAbout(
                          title: 'About', page: snapshot.data)),
                  Center(
                      child: MentoringPageMore(
                          title: "More",
                          email: snapshot.data!.email,
                          links: snapshot.data!.links))
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class MentoringPageAbout extends StatefulWidget {
  MentoringPageAbout({Key? key, required this.title, required this.page})
      : super(key: key);

  final String title;
  MentoringPageInstance? page;

  @override
  MentoringPageAboutState createState() => MentoringPageAboutState();
}

class MentoringPageAboutState extends State<MentoringPageAbout> {
  @override
  void initState() {
    super.initState();
  }

  Text getTextTitleWhenError() {
    return Text(widget.title,
        softWrap: true,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.black87,
              wordSpacing: 1,
              overflow: TextOverflow.fade,
              height: 1.2,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Center(
                              child: FutureBuilder(
                                  future: Globals().getFileUrl(
                                      'fedeapp_page_save_eu_students',
                                      widget.page!.id,
                                      0,
                                      'logo'),
                                  builder: (context,
                                      AsyncSnapshot<String> snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
                                      case ConnectionState.active:
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          return Column(children: [
                                            getTextTitleWhenError()
                                          ]);
                                        } else {
                                          return Center(
                                            child: CachedNetworkImage(
                                              width: 240,
                                              imageUrl:
                                                  snapshot.data.toString(),
                                              placeholder: (context, url) =>
                                                  Column(
                                                children: [
                                                  Text(widget.page!.title,
                                                      softWrap: true,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                            color:
                                                                Colors.black87,
                                                            wordSpacing: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            height: 1.2,
                                                          )),
                                                ],
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      getTextTitleWhenError(),
                                            ),
                                          );
                                        }
                                    }
                                  })),
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(widget.page!.description,
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
              ],
            )));
  }
}

class MentoringPageMore extends StatefulWidget {
  MentoringPageMore(
      {Key? key, required this.title, required this.email, required this.links})
      : super(key: key);

  final String title;
  final String email;
  final String links;

  @override
  MentoringPageMoreState createState() => MentoringPageMoreState();
}

class MentoringPageMoreState extends State<MentoringPageMore> {
  late final List<EventLinkInstance> links;
  var utils = Utils();

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
          Center(
            child: Text("Contact us directly",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.black87,
                      wordSpacing: 1,
                      overflow: TextOverflow.fade,
                      height: 1.2,
                    )),
          ),
          Center(
              child: ButtonBar(
            mainAxisSize: MainAxisSize.min,
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text('Email'),
                onPressed: () {
                  utils.sendEmail(email: widget.email);
                },
              )
            ],
          )),
          Center(child: utils.returnLinksWidget(widget.links, context)),
        ],
      ),
    ));
  }
}
