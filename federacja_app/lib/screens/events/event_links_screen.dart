import 'package:flutter/material.dart';

import '../../entity/global/link_item.dart';
import '../../utils/global_utils.dart';
import '../../utils/ui_utils.dart';

/// Event operations page - contact the team section
class EventsLinks extends StatefulWidget {
  const EventsLinks(
      {Key? key,
      required this.title,
      required this.email,
      required this.fb,
      required this.insta,
      required this.linkedin,
      this.links})
      : super(key: key);

  final String title;
  final String email;
  final String fb;
  final String insta;
  final String linkedin;
  final String? links;

  @override
  EventsLinksState createState() => EventsLinksState();
}

class EventsLinksState extends State<EventsLinks>
    with TickerProviderStateMixin {
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
              ),
              TextButton(
                child: const Text('Facebook'),
                onPressed: () {
                  utils.launchInBrowser(widget.fb);
                },
              ),
              TextButton(
                child: const Text('Instagram'),
                onPressed: () {
                  utils.launchInBrowser(widget.insta);
                },
              ),
              TextButton(
                child: const Text('LinkedIn'),
                onPressed: () {
                  utils.launchInBrowser(widget.linkedin);
                },
              ),
            ],
          )),
          UiUtils().returnLinksWidget(widget.links, context)
        ],
      ),
    ));
  }
}
