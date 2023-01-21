import 'package:pocketbase/pocketbase.dart';

class Globals {
  // -- Global Variables --
  final bool isProd = true;
  final List<String> regions = [
    "England",
    "Wales",
    "Scotland",
    "Northern Ireland"
  ];

  // -- PocketBase Client Setup And Methods --
  Future<PocketBase> getPBClient() async {
    final client = PocketBase('https://api.polsocfederation.com');
    //final appUserAuthData = await client.users.authViaEmail('?', '?');
    return client;
  }

  Future<String> getFileUrl(String collectionName, String recordId,
      int fileNumber, String fieldName) async {
    var client = await getPBClient();
    var record = await client.collection(collectionName).getOne(recordId);
    var firstFilename = record.getListValue<String>(fieldName)[fileNumber];

    return client.getFileUrl(record, firstFilename).toString();
  }
}
