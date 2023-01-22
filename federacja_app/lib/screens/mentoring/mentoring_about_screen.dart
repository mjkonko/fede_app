import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entity/mentoring/mentoring_page_instance.dart';
import '../../globals.dart';

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
                              child: Text(widget.title,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        color: Colors.black87,
                                        wordSpacing: 1,
                                        overflow: TextOverflow.fade,
                                        height: 1.2,
                                      ))),
                          Container(
                            padding: const EdgeInsets.only(top: 15),
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
              'fedeapp_page_mentoring', widget.page!.id, i, 'photos'),
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
