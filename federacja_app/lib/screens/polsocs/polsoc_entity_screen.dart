import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:federacja_app/entity/polsoc_instance.dart';
import 'package:flutter/material.dart';

import '../../entity/event_link_instance.dart';
import '../../globals.dart';
import '../../utils/utils.dart';

class PolSocEntityPage extends StatefulWidget {
  const PolSocEntityPage({Key? key, required this.title, required this.polsoc})
      : super(key: key);

  final String title;
  final PolSocInstance polsoc;

  @override
  State<PolSocEntityPage> createState() => _PolSocEntityPageState();
}

class _PolSocEntityPageState extends State<PolSocEntityPage>
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
          widget.polsoc.name),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
              child:
                  PolSocEntityAbout(title: 'About Us', polsoc: widget.polsoc)),
          Center(
              child: PolSocEntityMore(
            title: 'More',
            email: widget.polsoc.email,
            fb: widget.polsoc.facebook,
            insta: widget.polsoc.instagram,
            linkedin: widget.polsoc.linkedin,
            links: widget.polsoc.links,
          ))
        ],
      ),
    );
  }
}

class PolSocEntityAbout extends StatefulWidget {
  PolSocEntityAbout({Key? key, required this.polsoc, required this.title})
      : super(key: key);

  final String title;
  final PolSocInstance polsoc;

  @override
  PolSocEntityAboutState createState() => PolSocEntityAboutState();
}

class PolSocEntityAboutState extends State<PolSocEntityAbout> {
  @override
  void initState() {
    super.initState();
  }

  Text getTextTitleWhenError() {
    return Text(widget.polsoc.fullName,
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
                                      'polsocs', widget.polsoc.id, 0, 'logo'),
                                  builder: (context,
                                      AsyncSnapshot<String> snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
                                      case ConnectionState.active:
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          return Column(children: [
                                            const Text(
                                              'Failed to download the logo, please report this issue.',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
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
                                                  Text(widget.polsoc.fullName,
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
                            child: Text(widget.polsoc.description,
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

class PolSocEntityMore extends StatefulWidget {
  PolSocEntityMore(
      {Key? key,
      required this.title,
      this.email,
      this.fb,
      this.insta,
      this.linkedin,
      this.links})
      : super(key: key);

  final String title;
  String? email;
  String? fb;
  String? insta;
  String? linkedin;
  String? links;

  @override
  PolSocEntityMoreState createState() => PolSocEntityMoreState();
}

class PolSocEntityMoreState extends State<PolSocEntityMore> {
  late final List<EventLinkInstance> links;
  var utils = Utils();

  List<EventLinkInstance> parseLinks(String? links) {
    if (links == null) {
      return [];
    }

    final parsed = json.decode(links).cast<Map<String, dynamic>>();

    List<EventLinkInstance> list = parsed
        .map<EventLinkInstance>((json) => EventLinkInstance.fromJson(json))
        .toList();
    list.sort((item1, item2) => item1.id.compareTo(item2.id));

    return list;
  }

  List<Widget> returnGeneratedLinkButtons(List<EventLinkInstance> listOfLinks) {
    List<Widget> widgetList = [];

    for (var link in listOfLinks) {
      widgetList.add(TextButton(
          child: Text(link.title),
          onPressed: () {
            utils.openUrl(url: link.link);
          }));
    }

    return widgetList;
  }

  Widget returnLinksWidget(List<Widget> widgets) {
    if (widgets.isEmpty) {
      return Divider(
        color: Theme.of(context).colorScheme.secondary,
      );
    }

    return Column(
      children: [
        Divider(
          color: Theme.of(context).colorScheme.secondary,
        ),
        Center(
          child: Text("Additional links",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black87,
                    wordSpacing: 1,
                    overflow: TextOverflow.fade,
                    height: 2.0,
                  )),
        ),
        Center(
            child: ButtonBar(
                mainAxisSize: MainAxisSize.min,
                alignment: MainAxisAlignment.center,
                children: widgets)),
        Divider(
          color: Theme.of(context).colorScheme.secondary,
        )
      ],
    );
  }

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
            child: Text("Contact the organisers",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.black87,
                      wordSpacing: 1,
                      overflow: TextOverflow.fade,
                      height: 1.2,
                    )),
          ),
          const Center(
              child: ButtonBar(
            mainAxisSize: MainAxisSize.min,
            alignment: MainAxisAlignment.center,
            children: <Widget>[],
          )),
          returnLinksWidget(
              returnGeneratedLinkButtons(parseLinks(widget.links)))
        ],
      ),
    ));
  }
}
