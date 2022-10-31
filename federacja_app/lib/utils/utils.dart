import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as ul;
import 'package:url_launcher/url_launcher.dart';

import '../entity/event_link_instance.dart';

class Utils {
  Future<void> sendEmail({required String email}) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {'subject': '', 'body': ''});

    await ul.launchUrl(params, mode: ul.LaunchMode.externalApplication);
  }

  Future<void> launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

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

  List<Widget> returnGeneratedLinkButtons(String? links) {
    List<Widget> widgetList = [];
    var listOfLinks = parseLinks(links);

    for (var link in listOfLinks) {
      widgetList.add(TextButton(
          child: Text(link.title),
          onPressed: () {
            launchInBrowser(link.link);
          }));
    }

    return widgetList;
  }

  Widget returnLinksWidget(String? links, BuildContext context) {
    List<Widget> widgets = returnGeneratedLinkButtons(links);

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
}
