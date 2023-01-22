import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../entity/partners/partner_instance.dart';
import '../../globals.dart';

class PartnerPageAbout extends StatefulWidget {
  const PartnerPageAbout({Key? key, required this.partner, required this.title})
      : super(key: key);

  final String title;
  final PartnerInstance partner;

  @override
  PartnerPageAboutState createState() => PartnerPageAboutState();
}

class PartnerPageAboutState extends State<PartnerPageAbout> {
  @override
  void initState() {
    super.initState();
  }

  Text getTextTitleWhenError() {
    return Text(widget.partner.fullName,
        softWrap: true,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6!.copyWith(
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
                                      'partners', widget.partner.id, 0, 'logo'),
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
                                                  Text(widget.partner.fullName,
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
                            child: Text(widget.partner.description,
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

    for (int i = 0; i < widget.partner.photos; i++) {
      photosWidgets.add(FutureBuilder(
          future:
              Globals().getFileUrl('partners', widget.partner.id, i, 'photos'),
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
