import 'package:federacja_app/utils/partners/partners_utils.dart';
import 'package:federacja_app/utils/tile_utils.dart';
import 'package:flutter/material.dart';

import 'utils/events/events_utils.dart';

void main() {
  runApp(const FedeApp());
}

class FedeApp extends StatelessWidget {
  const FedeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FederacjaApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(
                  secondary: const Color.fromRGBO(0, 0, 0, 0.85),
                  tertiary:
                      const Color.fromRGBO(17, 53, 206, 0.8509803921568627)),
          scaffoldBackgroundColor: Theme.of(context).colorScheme.onBackground,
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
        ),
        home: const TiledHomePage(title: 'FederacjaApp'));
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
    return SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              title: const Image(
                image: AssetImage('lib/assets/img/logo.png'),
                height: 85,
              ),
              toolbarHeight: 75,
            ),
            body: Flex(direction: Axis.vertical, children: [
              Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        const EventUtils(),
                        const TileUtils().build(context),
                        const PartnerUtils(),
                      ])))
            ])));
  }
}
