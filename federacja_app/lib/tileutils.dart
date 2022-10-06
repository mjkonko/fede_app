import 'package:flutter/material.dart';

import 'about.dart';
import 'news.dart';

class TileUtils extends StatelessWidget {
  const TileUtils({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Build Home Page list of Tiles
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        padding: const EdgeInsets.all(0.5),
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 0.5,
        crossAxisSpacing: 0.5,
        shrinkWrap: true,
        children: generateTiles(context) as List<Widget>);
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
          Theme.of(context).colorScheme.primary),
      Tile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsPage()),
                )
              },
          'News',
          Theme.of(context).colorScheme.secondary),
      Tile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsPage()),
                )
              },
          'PolSocs',
          Theme.of(context).colorScheme.secondary),
      Tile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsPage()),
                )
              },
          'BCG Test',
          Colors.green)
    ];

    if (tiles.length.isOdd) {
      tiles.add(Tile(
          () => {}, 'Placeholder', Theme.of(context).colorScheme.background));
    }

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
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white)),
        ));
  }
}
