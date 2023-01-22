import 'package:pocketbase/pocketbase.dart';

abstract class Instance {
  fetch();
  parse(List<RecordModel> records);
}
