import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class Globals {
  bool isProd = true;
  List<String> regions = ["England", "Wales", "Scotland", "Northern Ireland"];

  Future<PocketBase> getPBClient() async {
    final client = PocketBase('https://api.polsocfederation.com');
    //final appUserAuthData = await client.users.authViaEmail('?', '?');
    return client;
  }

  Future<String> getFileUrl(String collectionName, String recordId,
      int fileNumber, String fieldName) async {
    var client = await getPBClient();
    var record = await client.collection(collectionName).getOne(recordId);
    var firstFilename = record.getListValue<String>(fieldName)[fileNumber];

    return client.getFileUrl(record, firstFilename).toString();
  }

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
}
