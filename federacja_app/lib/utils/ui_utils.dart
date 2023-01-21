import 'dart:convert';

import 'package:federacja_app/utils/global_utils.dart';
import 'package:flutter/material.dart';

import '../entity/global/link_item.dart';

class UiUtils {
  // -- Application UI Utilities --

  /// Method generating correct AppBar look, used globally
  AppBar getAppBar(
      BuildContext context, PreferredSizeWidget? child, String title) {
    const toolbarHeight = 75.0;
    const shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)));
    var textTheme = Theme.of(context)
        .textTheme
        .headline5!
        .copyWith(color: const Color(0xFFFFFFFF));

    if (child != null) {
      return AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          shape: shape,
          toolbarHeight: toolbarHeight,
          title: Text(title, style: textTheme),
          bottom: child);
    }
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        shape: shape,
        toolbarHeight: toolbarHeight,
        title: Text(title, style: textTheme));
  }

  /// Method generating a list of links from downloaded collections, used globally
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

  /// Helper method for returnLinksWidget
  List<Widget> returnGeneratedLinkButtons(String? links) {
    List<Widget> widgetList = [];
    var listOfLinks = parseLinks(links);

    for (var link in listOfLinks) {
      widgetList.add(TextButton(
          child: Text(link.title),
          onPressed: () {
            GlobalUtils().launchInBrowser(link.link);
          }));
    }

    return widgetList;
  }

  /// Helper method for returnGeneratedLinkButtons
  List<LinkItem> parseLinks(String? links) {
    if (links == null) {
      return [];
    }

    final parsed = json.decode(links).cast<Map<String, dynamic>>();

    List<LinkItem> list =
        parsed.map<LinkItem>((json) => LinkItem.fromJson(json)).toList();
    list.sort((item1, item2) => item1.id.compareTo(item2.id));

    return list;
  }
}
