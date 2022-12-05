import 'package:federacja_app/entity/partner_instance.dart';
import 'package:federacja_app/utils/tileutils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../globals.dart';
import '../screens/partners/partner_entity_screen.dart';

class PartnerUtils extends StatefulWidget {
  const PartnerUtils({Key? key}) : super(key: key);

  @override
  PartnerState createState() => PartnerState();
}

class PartnerState extends State<PartnerUtils> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PartnerInstance>>(
      future: fetchPartner(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            snapshot.error.toString();
          }
          return Center(
              child: Text('There are no partner tiles available',
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.black)));
        } else if (snapshot.hasData) {
          return PartnerList(
            list: snapshot.data!,
            context: context,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class PartnerList extends StatelessWidget {
  const PartnerList(
      {Key? key, required this.list, required BuildContext context})
      : super(key: key);
  final List<PartnerInstance> list;

  Tile makeTile(BuildContext context, PartnerInstance item) {
    return Tile(
        () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PartnerEntityPage(
                          title: item.fullName,
                          partner: PartnerInstance(
                            id: item.id,
                            description: item.description,
                            email: item.email,
                            links: item.links,
                            //'[{"id": 1, "name": "Test", "venue": "Venue", "time": "2022-09-25T12:15:23.701Z", "description": "desc"},{"id": 2, "name": "Test", "venue": "Venue", "time": "2022-09-25T12:15:23.701Z", "description": "desc"}]',
                            created: item.created,
                            updated: item.updated,
                            verified: item.verified,
                            active: item.active,
                            fullName: item.fullName,
                          ),
                        )),
              )
            },
        item.fullName,
        Theme.of(context).colorScheme.surfaceTint);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        padding: const EdgeInsets.all(0.5),
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 0.5,
        crossAxisSpacing: 0.5,
        shrinkWrap: true,
        children: generateTiles(context));
  }

  List<Widget> generateTiles(BuildContext context) {
    List<Tile> tiles = [];
    for (int i = 0; i < list.length; i++) {
      tiles.add(makeTile(context, list[i]));
    }

    // if (tiles.length.isOdd) {
    //   tiles.add(ImageLogoTile(
    //       () => {}, 'Placeholder', Theme.of(context).colorScheme.secondary));
    // }

    return tiles;
  }
}

Future<List<PartnerInstance>> fetchPartner() async {
  var client = await Globals().getPBClient();
  var records = await client.records
      .getFullList('partners', batch: 200, sort: '-created');

  if (records.isNotEmpty) {
    return parsePartner(records);
  } else {
    throw Exception('Failed to load event items');
  }
}

List<PartnerInstance> parsePartner(List<RecordModel> records) {
  List<PartnerInstance> list = records
      .map<PartnerInstance>((json) => PartnerInstance.fromRecordModel(json))
      .toList();
  return list;
}
