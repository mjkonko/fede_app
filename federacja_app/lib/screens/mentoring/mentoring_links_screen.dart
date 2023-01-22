import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entity/global/link_item.dart';
import '../../utils/ui_utils.dart';

class MentoringPageLinks extends StatefulWidget {
  const MentoringPageLinks(
      {Key? key, required this.title, required this.email, required this.links})
      : super(key: key);

  final String title;
  final String email;
  final String links;

  @override
  MentoringPageLinksState createState() => MentoringPageLinksState();
}

class MentoringPageLinksState extends State<MentoringPageLinks> {
  late final List<LinkItem> links;

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
          Center(child: UiUtils().returnLinksWidget(widget.links, context)),
        ],
      ),
    ));
  }
}
