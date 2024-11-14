import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';

import 'package:taskapp/modules/task/controller/bloc/task_bloc.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/modules/task/ui/widgets/create_task_form.dart';

void main() {
  late MockTaskBloc mockTaskBloc;
  late GlobalKey<FormBuilderState> formKey;

  setUp(() {
    mockTaskBloc = MockTaskBloc();
    formKey = GlobalKey<FormBuilderState>();
  });

  Widget createTestWidget({Task? task, bool? isUpdate}) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<TaskBloc>.value(
          value: mockTaskBloc,
          child: CreateTaskForm(
            formKey: formKey,
            task: task,
            isUpdate: isUpdate,
            constraints: const BoxConstraints(
              maxWidth: 400,
              maxHeight: 800,
            ),
            onConfirmCreate: () {},
            onConfirmEdit: () {},
          ),
        ),
      ),
    );
  }

  group('CreateTaskForm Widget', () {
    testWidgets('renders form fields correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(FormBuilder), findsOneWidget);
      expect(find.byType(CustomRoundedTextFormField), findsNWidgets(2));
      expect(find.byType(CustomButton), findsOneWidget);
    });

    // testWidgets('shows create button text when isUpdate is null',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(createTestWidget());

    //   expect(find.text('Crear Tarea'), findsOneWidget);
    //
    // });

    // testWidgets('shows update button text when isUpdate is true',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(createTestWidget(isUpdate: true));

    //   expect(find.text('Actualizar Tarea'), findsOneWidget);
    //
    // });

    // testWidgets('fills form with task data when provided',
    //     (WidgetTester tester) async {
    //   final task = Task(
    //     title: 'Test Task',
    //     description: 'Test Description',
    //     status: 'pending',
    //     createdAt: DateTime.now(),
    //   );

    //   await tester.pumpWidget(createTestWidget(task: task, isUpdate: true));

    //   expect(find.text('Test Task'), findsOneWidget);
    //   expect(find.text('Test Description'), findsOneWidget);
    // });

    // testWidgets('validates form on button press', (WidgetTester tester) async {
    //   await tester.pumpWidget(createTestWidget());

    //   // Tap the submit button without filling the form
    //   await tester.tap(find.byType(CustomButton));
    //   await tester.pump();

    //   // Verify error messages are shown
    //   expect(find.text('El titulo de la tarea es requerido.'), findsOneWidget);
    //   expect(
    //       find.text('La description de la tarea es requerida'), findsOneWidget);
    // });
  });
}

class MockTaskBloc extends MockBloc<TaskEvent, TaskState> implements TaskBloc {
  @override
  Stream<TaskState> get stream => Stream.value(const TaskState());
}
