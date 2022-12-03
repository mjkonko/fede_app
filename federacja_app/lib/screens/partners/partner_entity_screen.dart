import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../entity/event_link_instance.dart';
import '../../entity/partner_instance.dart';
import '../../globals.dart';
import '../../utils/utils.dart';

class PartnerEntityPage extends StatefulWidget {
  const PartnerEntityPage(
      {Key? key, required this.title, required this.partner})
      : super(key: key);

  final String title;
  final PartnerInstance partner;

  @override
  State<PartnerEntityPage> createState() => _PartnerEntityPageState();
}

class _PartnerEntityPageState extends State<PartnerEntityPage>
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
          widget.partner.shortName),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
              child: PartnerEntityAbout(
                  title: 'About Us', partner: widget.partner)),
          Center(
              child: PartnerEntityMore(
                  title: 'More',
                  email: widget.partner.email,
                  links: widget.partner.links))
        ],
      ),
    );
  }
}

class PartnerEntityAbout extends StatefulWidget {
  const PartnerEntityAbout(
      {Key? key, required this.partner, required this.title})
      : super(key: key);

  final String title;
  final PartnerInstance partner;

  @override
  PartnerEntityAboutState createState() => PartnerEntityAboutState();
}

class PartnerEntityAboutState extends State<PartnerEntityAbout> {
  @override
  void initState() {
    super.initState();
  }

  Text getTextTitleWhenError() {
    return Text(widget.partner.fullName,
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
                                      'polsocs', widget.partner.id, 0, 'logo'),
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
                          )
                        ],
                      ),
                    ))
              ],
            )));
  }
}

class PartnerEntityMore extends StatefulWidget {
  PartnerEntityMore(
      {Key? key, required this.title, required this.email, this.links})
      : super(key: key);

  final String title;
  final String email;
  String? links;

  @override
  PartnerEntityMoreState createState() => PartnerEntityMoreState();
}

class PartnerEntityMoreState extends State<PartnerEntityMore> {
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
          Center(child: utils.returnLinksWidget(widget.links, context)),
        ],
      ),
    ));
  }
}
