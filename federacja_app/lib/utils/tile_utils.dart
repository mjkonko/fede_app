import 'package:federacja_app/screens/mentoring/mentoring_main_screen.dart';
import 'package:federacja_app/screens/polsocs/polsocs_list_screen.dart';
import 'package:federacja_app/screens/save_eu/save_eu_screen.dart';
import 'package:federacja_app/utils/global_utils.dart';
import 'package:flutter/material.dart';

import '../screens/about/about_main_screen.dart';

/// Main Screen Static Tiles Generation Class
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

  /// Use this method to add more static tile objects
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
      // Tile(
      //     () => {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const NewsPage()),
      //           )
      //         },
      //     'News',
      //     Theme.of(context).colorScheme.surfaceTint),
      Tile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PolSocsListPage()),
                )
              },
          'Polish Societies',
          Theme.of(context).colorScheme.surfaceTint),
      ImageLogoTile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SaveEUPage()),
                )
              },
          'SaveEU Students',
          Theme.of(context).colorScheme.tertiary,
          'lib/assets/img/save_eu_logo.png'),
      Tile(
          () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MentoringPage()),
                )
              },
          'Mentoring',
          Theme.of(context).colorScheme.surfaceTint),
      Tile(
          () => {
                GlobalUtils()
                    .launchInBrowser("https://polsocfederation.com/guides")
              },
          'Freshers Guides',
          Theme.of(context).colorScheme.surfaceTint),
      Tile(
          () => {
                GlobalUtils()
                    .launchInBrowser("https://polsocfederation.com/press")
              },
          'Press',
          Theme.of(context).colorScheme.secondary)
    ];

    return tiles;
  }
}

/// Static Tile with Text
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

/// Tile with Local Logo File
class ImageLogoTile extends Tile {
  final String image;

  const ImageLogoTile(Function action, String title, Color color, this.image,
      {Key? key})
      : super(action, title, color, key: key);

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
            foregroundDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage(image),
                ))));
  }
}
