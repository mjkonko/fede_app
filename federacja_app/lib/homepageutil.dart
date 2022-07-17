import 'package:flutter/material.dart';

class HomePageUtil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Build Home Page list of Tiles
    return Expanded(
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1,
            padding: const EdgeInsets.all(1.0),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            children: [
          Tile(test, 'Tile', Colors.red),
          Tile(test2, 'Tile', Colors.indigo),
          Tile(test, 'Tile', Colors.blueGrey),
          Tile(test, 'Tile', Colors.black26),
          Tile(test, 'Tile', Colors.redAccent),
          Tile(test, 'Tile', Colors.purpleAccent),
          Tile(test, 'Tile', Colors.lightBlue),
          Tile(test, 'Tile', Colors.lightGreenAccent),
          Tile(test2, 'Tile', Colors.indigo),
          Tile(test, 'Tile', Colors.blueGrey)
        ]));
  }

  test() {
    print("Click event on Container");
  }

  test2() {
    print("Click event on 2");
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
          padding: const EdgeInsets.all(2.0),
          color: color,
          alignment: Alignment.center,
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white)),
        ));
  }
}
