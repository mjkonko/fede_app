import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class Globals {
  bool isProd = true;
  List<String> regions = ["England", "Wales", "Scotland", "Northern Ireland"];

  PocketBase getPBClient() {
    return PocketBase('https://nenna.is');
  }

  AppBar getAppBar(
      BuildContext context, PreferredSizeWidget? child, String title) {
    if (child != null) {
      return AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          toolbarHeight: 75,
          title: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: const Color(0xFFFFFFFF))),
          bottom: child);
    }
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        toolbarHeight: 75,
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: const Color(0xFFFFFFFF))));
  }
}
