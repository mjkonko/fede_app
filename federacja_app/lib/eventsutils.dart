import 'package:federacja_app/entity/EventInstance.dart';
import 'package:federacja_app/events.dart';
import 'package:flutter/material.dart';

class EventUtils extends StatelessWidget {
  const EventUtils({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Build Home Page list of Tiles
    return ListView(
        padding: const EdgeInsets.all(0.5),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          EventTile(
              () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventsPage(
                                event: EventInstance(
                                    1,
                                    "infoTitle",
                                    "infoSubtitle",
                                    "infoText",
                                    "contactEmail",
                                    "facebookPage",
                                    "instaPage",
                                    "linkedInPage", []),
                              )),
                    )
                  },
              'title',
              Theme.of(context).colorScheme.primary),
          EventTile(
              () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventsPage(
                                event: EventInstance(
                                    1,
                                    "infoTitle",
                                    "infoSubtitle",
                                    "infoText",
                                    "contactEmail",
                                    "facebookPage",
                                    "instaPage",
                                    "linkedInPage", []),
                              )),
                    )
                  },
              'title',
              Theme.of(context).colorScheme.primary),
        ]);
  }
}

class EventTile extends StatelessWidget {
  final Function action;
  final String title;
  final Color color;

  const EventTile(this.action, this.title, this.color, {Key? key})
      : super(key: key);

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
