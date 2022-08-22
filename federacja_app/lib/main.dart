import 'package:federacja_app/tileutils.dart';
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
      title: 'FederacjaApp',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(255, 242, 235, 0.95),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(secondary: Colors.blueGrey)),
      home: const TiledHomePage(title: 'FederacjaApp'),
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
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          title: const Image(
            image: AssetImage('lib/assets/img/logo.png'),
            height: 85,
          ),
          toolbarHeight: 75,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[TileUtils().build(context)],
          ),
        ));
  }
}
