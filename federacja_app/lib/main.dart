import 'package:federacja_app/homepageutil.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FedeApp());
}

class FedeApp extends StatelessWidget {
  const FedeApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Federacja',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(secondary: Colors.blueGrey)),
      home: const TiledHomePage(title: 'Federacja'),
    );
  }
}

class TiledHomePage extends StatefulWidget {
  const TiledHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TiledHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TiledHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Below is the space for tiles',
              ),
              HomePageUtil().build(context)
            ],
          ),
        ));
  }
}
