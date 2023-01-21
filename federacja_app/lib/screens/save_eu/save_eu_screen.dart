import 'package:cached_network_image/cached_network_image.dart';
import 'package:federacja_app/entity/save_eu/save_eu_page_instance.dart';
import 'package:federacja_app/utils/saveeu/saveeu_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entity/global/link_item.dart';
import '../../globals.dart';
import '../../utils/global_utils.dart';
import '../../utils/ui_utils.dart';

class SaveEUPage extends StatefulWidget {
  const SaveEUPage({Key? key}) : super(key: key);

  final String title = "SaveEU Students";

  @override
  State<SaveEUPage> createState() => _SaveEUPagePageState();
}

class _SaveEUPagePageState extends State<SaveEUPage>
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
                    text: "About Us",
                  ),
                  Tab(
                    text: "More",
                  )
                ]),
            widget.title),
        body: FutureBuilder<SaveEUPageInstance>(
          future: fetchSaveEUPage(),
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
                      child: SaveEntityAbout(
                          title: 'About Us', page: snapshot.data)),
                  Center(
                      child: SaveEUMore(
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

class SaveEntityAbout extends StatefulWidget {
  SaveEntityAbout({Key? key, this.page, required this.title}) : super(key: key);

  final String title;
  SaveEUPageInstance? page;

  @override
  SaveEntityAboutState createState() => SaveEntityAboutState();
}

class SaveEntityAboutState extends State<SaveEntityAbout> {
  @override
  void initState() {
    super.initState();
  }

  Text getTextTitleWhenError() {
    return Text(widget.page!.title,
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
                          ),
                          returnPhotosIfAvailable()
                        ],
                      ),
                    ))
              ],
            )));
  }

  Column returnPhotosIfAvailable() {
    return Column(
      children: getPhotos(),
    );
  }

  List<Widget> getPhotos() {
    List<Widget> photosWidgets = [];

    for (int i = 0; i < widget.page!.photos; i++) {
      photosWidgets.add(FutureBuilder(
          future: Globals().getFileUrl(
              'fedeapp_page_save_eu_students', widget.page!.id, i, 'photos'),
          builder: (context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Column(children: [
                    Text(
                      "Couldn't load the picture ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    )
                  ]);
                } else {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 12.5),
                    child: CachedNetworkImage(
                        width: 600,
                        imageUrl: snapshot.data.toString(),
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) => Container()),
                  ));
                }
            }
          }));
    }
    return photosWidgets;
  }
}

class SaveEUMore extends StatefulWidget {
  const SaveEUMore(
      {Key? key, required this.title, required this.email, required this.links})
      : super(key: key);

  final String title;
  final String email;
  final String links;

  @override
  SaveEUMoreState createState() => SaveEUMoreState();
}

class SaveEUMoreState extends State<SaveEUMore> {
  late final List<LinkItem> links;
  var utils = GlobalUtils();

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
          Center(child: UiUtils().returnLinksWidget(widget.links, context)),
        ],
      ),
    ));
  }
}
