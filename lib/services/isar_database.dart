import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:taskapp/modules/task/data/models/task.dart';

class IsarDatabase {
  static Future<Isar> get instance async {
    final directory = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([TaskSchema],
          directory: directory.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }
}
