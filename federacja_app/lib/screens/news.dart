import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocketbase/src/dtos/record_model.dart';

import '../entity/NewsItem.dart';
import '../globals.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  final String title = "News";

  @override
  NewsState createState() => NewsState();
}

class NewsState extends State<NewsPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
        body: Scaffold(
            body: FutureBuilder<List<NewsItem>>(
          future: fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                snapshot.error.toString();
              }
              return const Center(child: Text('An error has occurred!'));
            } else if (snapshot.hasData) {
              return NewsList(list: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )));
  }
}

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.list}) : super(key: key);

  final List<NewsItem> list;

  Text parseDT(DateTime dt) =>
      Text("${dt.day}/${dt.month} ${DateFormat('hh:mm').format(dt)}",
          style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w300,
              fontSize: 9,
              letterSpacing: 1.5));

  Card makeCard(NewsItem item) => Card(
        elevation: 10.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: makeListTile(item),
        ),
      );

  ListTile makeListTile(NewsItem item) => ListTile(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      leading: Container(
        padding: const EdgeInsets.only(right: 8.0),
        decoration: const BoxDecoration(
            border: Border(right: BorderSide(width: 0.75, color: Colors.red))),
        child: const Icon(Icons.newspaper_sharp, color: Colors.black),
      ),
      title: Text(
        item.title,
        style:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
      ),
      subtitle: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 6.0),
                  child: Text(item.text,
                      style: const TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w400))),
            )
          ],
        ),
        Row(children: <Widget>[
          Expanded(
              flex: 4,
              child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 9.0),
                  child: parseDT(DateTime.parse(item.date))))
        ])
      ]));

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      reverse: false,
      cacheExtent: 75.0,
      itemBuilder: (context, index) {
        return makeCard(list[index]);
      },
    );
  }
}

Future<List<NewsItem>> fetchNews() async {
  // alternatively you can also fetch all records at once via getFullList:
  final records = await Globals()
      .getPBClient()
      .records
      .getFullList('news', batch: 200, sort: '-created');
  if (records.isNotEmpty) {
    return parseNews(records);
  } else {
    throw Exception('Failed to load news items');
  }
}

List<NewsItem> parseNews(List<RecordModel> records) {
  List<NewsItem> list =
      records.map<NewsItem>((json) => NewsItem.fromRecordModel(json)).toList();
  return list;
}
