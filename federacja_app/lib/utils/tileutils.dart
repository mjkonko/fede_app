import 'package:federacja_app/screens/polsocs/polsocs.dart';
import 'package:federacja_app/screens/save_eu/save_eu_screen.dart';
import 'package:flutter/material.dart';

import '../screens/about.dart';
import '../screens/news.dart';

class TileUtils extends StatelessWidget {
  const TileUtils({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Build Home Page list of Tiles
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        padding: const EdgeInsets.all(0.25),
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 0.25,
        crossAxisSpacing: 0.25,
        shrinkWrap: true,
        children: generateTiles(context));
  }

  //Use this element to add more static tile objects
  List<Widget> generateTiles(BuildContext context) {
    List<Tile> tiles = [
      Tile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                )
              },
          'About',
          Theme.of(context).colorScheme.surfaceTint),
      Tile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsPage()),
                )
              },
          'News',
          Theme.of(context).colorScheme.surfaceTint),
      Tile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PolSocsPage()),
                )
              },
          'PolSocs',
          Theme.of(context).colorScheme.surfaceTint),
      Tile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaveEUPage()),
                )
              },
          'SaveEU Students',
          Theme.of(context).colorScheme.tertiary)
    ];
    return tiles;
  }
}

class Tile extends StatelessWidget {
  final Function action;
  final String title;
  final Color color;

  const Tile(this.action, this.title, this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          action();
        },
        child: Container(
          padding: const EdgeInsets.all(1.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          child: Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white)),
        ));
  }
}

class ImageLogoTile extends Tile {
  const ImageLogoTile(Function action, String title, Color color, {Key? key})
      : super(action, title, color, key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Container(
            padding: const EdgeInsets.all(1.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
            foregroundDecoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('lib/assets/img/logo.png'),
            ))));
  }
}
