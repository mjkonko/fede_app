import 'package:federacja_app/entity/partners/partner_instance.dart';
import 'package:federacja_app/utils/tile_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../globals.dart';
import '../../screens/partners/partner_entity_screen.dart';
import '../Instance.dart';

class PartnerUtils extends StatefulWidget {
  const PartnerUtils({Key? key}) : super(key: key);

  @override
  PartnerState createState() => PartnerState();
}

class PartnerState extends State<PartnerUtils>
    with TickerProviderStateMixin
    implements Instance {
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<List<PartnerInstance>> fetch() async {
    var client = await Globals().getPBClient();
    var records = await client
        .collection('partners')
        .getFullList(batch: 200, sort: '-created');

    if (records.isNotEmpty) {
      return parse(records);
    } else {
      throw Exception('Failed to load event items');
    }
  }

  @override
  List<PartnerInstance> parse(List<RecordModel> records) {
    List<PartnerInstance> list = records
        .map<PartnerInstance>((json) => PartnerInstance.fromRecordModel(json))
        .toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PartnerInstance>>(
      future: fetch(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            snapshot.error.toString();
          }
          return const SizedBox.shrink();
        } else if (snapshot.hasData) {
          return PartnerList(
            list: snapshot.data!,
            context: context,
          );
        } else {
          return const SizedBox.shrink();
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
                            photos: item.photos,
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
