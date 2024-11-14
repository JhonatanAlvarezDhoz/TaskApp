import 'package:flutter_test/flutter_test.dart';
import 'package:taskapp/modules/task/controller/helpers/task_bloc_helpers.dart';
import 'package:taskapp/modules/task/data/models/task.dart';

void main() {
  group('TaskBlocHelpres', () {
    test('changeFormValueToTask should create task correctly', () {
      final formValue = {
        'title': '  Test Task  ',
        'description': '  Test Description  ',
      };

      final result = TaskBlocHelpres.changeFormValueToTask(formValue);

      expect(result, isA<Task>());
      expect(result.title, 'Test Task');
      expect(result.description, 'Test Description');
      expect(result.status, 'pending');
      expect(result.createdAt, isA<DateTime>());
    });

    test('changeFormValueToTask should throw exception for invalid data', () {
      final formValue = {
        'invalid': 'data',
      };

      expect(
        () => TaskBlocHelpres.changeFormValueToTask(formValue),
        throwsException,
      );
    });

    test('changeFormValueToEditTask should return correct list with task data',
        () {
      final formValue = {
        'id': 1,
        'title': '  Updated Task  ',
        'description': '  Updated Description  ',
        'status': 'completed',
        'createdAt': '2024-03-15 10:30',
      };

      final result = TaskBlocHelpres.changeFormValueToEditTask(formValue);

      expect(result, isA<List>());
      expect(result.length, 2);
      expect(result[0], 1);
      expect(result[1], isA<Task>());
      expect(result[1].title, 'Updated Task');
      expect(result[1].description, 'Updated Description');
      expect(result[1].status, 'completed');
    });

    test('changeFormValueToEditTask should throw exception for invalid data',
        () {
      final formValue = {
        'invalid': 'data',
      };

      expect(
        () => TaskBlocHelpres.changeFormValueToEditTask(formValue),
        throwsException,
      );
    });
  });
}
