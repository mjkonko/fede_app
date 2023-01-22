import 'package:flutter/material.dart';

import '../../../entity/global/link_item.dart';
import '../../../utils/global_utils.dart';
import '../../../utils/ui_utils.dart';

class PolSocEntityLinks extends StatefulWidget {
  PolSocEntityLinks(
      {Key? key, required this.title, required this.email, this.links})
      : super(key: key);

  final String title;
  final String email;
  String? links;

  @override
  PolSocEntityLinksState createState() => PolSocEntityLinksState();
}

class PolSocEntityLinksState extends State<PolSocEntityLinks> {
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
