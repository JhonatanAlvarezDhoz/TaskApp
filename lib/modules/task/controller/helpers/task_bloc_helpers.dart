import 'dart:developer';

import 'package:taskapp/modules/task/data/models/task.dart';

class TaskBlocHelpres {
  static Task changeFormValueToTask(Map<String, dynamic> formValue) {
    try {
      final task = Task(
          title: formValue["title"].toString().trim(),
          description: formValue["description"].toString().trim(),
          status: "pending",
          createdAt: DateTime.now());

      return task;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
