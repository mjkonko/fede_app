import 'package:pocketbase/pocketbase.dart';

class Globals {
  bool isProd = true;

  PocketBase getPBClient() {
    return PocketBase('https://nenna.is');
  }
}
