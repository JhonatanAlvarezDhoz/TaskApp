import 'dart:developer';

import 'package:taskapp/helpers/formater.dart';
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

  static List<dynamic> changeFormValueToEditTask(
    Map<String, dynamic> formValue,
  ) {
    try {
      late Task task;

      final id = formValue["id"];
      final createAt = Formater.parseFormattedDateTime(
          formValue["createdAt"].toString().trim());

      if (createAt != null) {
        final newTask = Task(
          title: formValue["title"].toString().trim(),
          description: formValue["description"].toString().trim(),
          status: formValue["status"].toString().trim(),
          createdAt: createAt,
        );
        task = newTask;
      }

      return [id, task];
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
