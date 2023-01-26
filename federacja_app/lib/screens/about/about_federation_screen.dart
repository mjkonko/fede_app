import 'package:cached_network_image/cached_network_image.dart';
import 'package:federacja_app/entity/about/about_page_instance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../globals.dart';

class AboutFederation extends StatefulWidget {
  AboutFederation({Key? key, required this.title, this.page}) : super(key: key);

  final String title;
  AboutPageInstance? page;

  @override
  AboutFederationState createState() => AboutFederationState();
}

class AboutFederationState extends State<AboutFederation>
    with TickerProviderStateMixin {
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
                        Text(widget.page!.textTitle,
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      color: Colors.black87,
                                      wordSpacing: 1,
                                      overflow: TextOverflow.fade,
                                      height: 1.2,
                                    )),
                        Text(widget.page!.text1,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.black87,
                                      wordSpacing: 1,
                                      overflow: TextOverflow.fade,
                                      height: 1.5,
                                    )),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(widget.page!.text2,
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
            ])));
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
          future: Globals()
              .getFileUrl('fedeapp_page_about', widget.page!.id, i, 'photos'),
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
