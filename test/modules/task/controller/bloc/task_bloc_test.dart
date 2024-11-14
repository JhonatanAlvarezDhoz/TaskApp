// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:taskapp/modules/task/controller/bloc/task_bloc.dart';
// import 'package:taskapp/modules/task/data/models/task.dart';
// import 'package:taskapp/modules/task/data/usecase/usecase.dart';

// // Esta línea genera el archivo task_bloc_test.mocks.dart con nuestros mocks
// @GenerateMocks([
//   UcCreateTask,
//   UcUpdateTask,
//   UcDeleteTask,
//   UcChangeStatus,
//   UcGetTaskNoParams,
//   UcFilterTask
// ])
// import 'task_bloc_test.mocks.dart'; // Importamos los mocks generados

// void main() {
//   late TaskBloc taskBloc;
//   late MockUcCreateTask mockUcCreateTask;
//   late MockUcUpdateTask mockUcUpdateTask;
//   late MockUcDeleteTask mockUcDeleteTask;
//   late MockUcChangeStatus mockUcChangeStatus;
//   late MockUcGetTaskNoParams mockUcGetTaskNoParams;
//   late MockUcFilterTask mockUcFilterTask;
//   late GlobalKey<FormBuilderState> formKey;

//   setUp(() {
//     mockUcCreateTask = MockUcCreateTask();
//     mockUcUpdateTask = MockUcUpdateTask();
//     mockUcDeleteTask = MockUcDeleteTask();
//     mockUcChangeStatus = MockUcChangeStatus();
//     mockUcGetTaskNoParams = MockUcGetTaskNoParams();
//     mockUcFilterTask = MockUcFilterTask();
//     formKey = GlobalKey<FormBuilderState>();

//     taskBloc = TaskBloc(
//       ucCreateTask: mockUcCreateTask,
//       ucUpdateTask: mockUcUpdateTask,
//       ucDeleteTask: mockUcDeleteTask,
//       ucChangeStatus: mockUcChangeStatus,
//       ucGetTaskNoParams: mockUcGetTaskNoParams,
//       ucFilterTask: mockUcFilterTask,
//     );
//   });

//   tearDown(() {
//     taskBloc.close();
//   });

//   group('TaskBloc Tests', () {
//     final mockTask = Task(
//       title: 'Test Task',
//       description: 'Test Description',
//       status: 'pending',
//       createdAt: DateTime.now(),
//     );

//     test('initial state should be correct', () {
//       expect(taskBloc.state, const TaskState());
//     });

//     group('GetTask Tests', () {
//       test('should emit task list when getting tasks successfully', () async {
//         when(mockUcGetTaskNoParams.call()).thenAnswer((_) async => [mockTask]);

//         final expectedStates = [
//           TaskState(taskList: [mockTask]),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(OnGetTaskEvent());
//       });

//       test('should maintain current state when getting tasks fails', () async {
//         when(mockUcGetTaskNoParams.call())
//             .thenThrow(Exception('Failed to get tasks'));

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder([const TaskState(taskList: [])]),
//         );

//         taskBloc.add(OnGetTaskEvent());
//       });
//     });

//     group('CreateTask Tests', () {
//       test('should emit success state when creating task successfully',
//           () async {
//         when(mockUcCreateTask.call(params: any)).thenAnswer((_) async => true);
//         when(mockUcGetTaskNoParams.call()).thenAnswer((_) async => [mockTask]);

//         final expectedStates = [
//           const TaskState(taskStatus: TaskStatus.loading),
//           const TaskState(
//             taskStatus: TaskStatus.created,
//             message: "Tarea Creada con Exito",
//           ),
//           TaskState(taskList: [mockTask]),
//           const TaskState(taskStatus: TaskStatus.initial),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(OnCreateTaskEvent(taskFormKey: formKey));
//       });

//       test('should emit error state when creating task fails', () async {
//         when(mockUcCreateTask.call(params: any))
//             .thenThrow(Exception('Failed to create task'));

//         final expectedStates = [
//           const TaskState(taskStatus: TaskStatus.loading),
//           TaskState(
//             taskStatus: TaskStatus.error,
//             errorMessage: Exception('Failed to create task').toString(),
//           ),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(OnCreateTaskEvent(taskFormKey: formKey));
//       });
//     });

//     group('UpdateTask Tests', () {
//       test('should emit success state when updating task successfully',
//           () async {
//         when(mockUcUpdateTask.call(params: any)).thenAnswer((_) async => true);
//         when(mockUcGetTaskNoParams.call()).thenAnswer((_) async => [mockTask]);

//         final expectedStates = [
//           const TaskState(taskStatus: TaskStatus.loading),
//           const TaskState(
//             taskStatus: TaskStatus.updated,
//             message: "Tarea actualizada con Exito",
//           ),
//           TaskState(taskList: [mockTask]),
//           const TaskState(taskStatus: TaskStatus.initial),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(OnUpdateTaskEvent(taskFormKey: formKey));
//       });
//     });

//     group('DeleteTask Tests', () {
//       test('should emit success state when deleting task successfully',
//           () async {
//         const taskId = 1;
//         when(mockUcDeleteTask.call(params: any)).thenAnswer((_) async => true);
//         when(mockUcGetTaskNoParams.call()).thenAnswer((_) async => [mockTask]);

//         final expectedStates = [
//           const TaskState(taskStatus: TaskStatus.loading),
//           const TaskState(
//             taskStatus: TaskStatus.deleted,
//             message: "Tarea Eliminada con exito.",
//           ),
//           TaskState(taskList: [mockTask]),
//           const TaskState(taskStatus: TaskStatus.initial),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(const OnDeleteTaskEvent(taskId: taskId));
//       });
//     });

//     group('ChangeStatus Tests', () {
//       test('should emit success state when changing status to pending',
//           () async {
//         const taskId = 1;
//         when(mockUcChangeStatus.call(params: any))
//             .thenAnswer((_) async => true);
//         when(mockUcGetTaskNoParams.call()).thenAnswer((_) async => [mockTask]);

//         final expectedStates = [
//           const TaskState(taskStatus: TaskStatus.loading),
//           const TaskState(
//             taskStatus: TaskStatus.success,
//             message: "Estado de tarea Cambiado a por hacer",
//           ),
//           TaskState(taskList: [mockTask]),
//           const TaskState(taskStatus: TaskStatus.initial),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(const OnChangeStatusToPending(
//           taskId: taskId,
//           status: 'pending',
//         ));
//       });

//       test('should emit success state when changing status to completed',
//           () async {
//         const taskId = 1;
//         when(mockUcChangeStatus.call(params: any))
//             .thenAnswer((_) async => true);
//         when(mockUcGetTaskNoParams.call()).thenAnswer((_) async => [mockTask]);

//         final expectedStates = [
//           const TaskState(taskStatus: TaskStatus.loading),
//           const TaskState(
//             taskStatus: TaskStatus.success,
//             message: "Estado de tarea Cambiado a completado",
//           ),
//           TaskState(taskList: [mockTask]),
//           const TaskState(taskStatus: TaskStatus.initial),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(const OnChangeStatusToCompleted(
//           taskId: taskId,
//           status: 'completed',
//         ));
//       });
//     });

//     group('FilterTask Tests', () {
//       test('should emit filtered tasks when filtering successfully', () async {
//         final filteredTask = Task(
//           title: mockTask.title,
//           description: mockTask.description,
//           status: 'completed',
//           createdAt: mockTask.createdAt,
//         );
//         when(mockUcFilterTask.call(params: any))
//             .thenAnswer((_) async => [filteredTask]);

//         final expectedStates = [
//           TaskState(taskList: [filteredTask]),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(const OnFilterTaskEvent(filterStatus: 'completed'));
//       });

//       test('should emit empty list when no tasks match filter', () async {
//         when(mockUcFilterTask.call(params: any)).thenAnswer((_) async => []);

//         final expectedStates = [
//           const TaskState(taskList: []),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(const OnFilterTaskEvent(filterStatus: 'completed'));
//       });
//     });

//     group('ChangeFilterStatus Tests', () {
//       test('should get all tasks when filter status is "Todas"', () async {
//         when(mockUcGetTaskNoParams.call()).thenAnswer((_) async => [mockTask]);

//         final expectedStates = [
//           const TaskState(filterStatus: "Todas"),
//           TaskState(taskList: [mockTask]),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc.add(const OnChangeFilterStatusEvent(filterStatus: "Todas"));
//       });

//       test('should filter tasks when status is "Completadas"', () async {
//         final completedTask = Task(
//           title: mockTask.title,
//           description: mockTask.description,
//           status: 'completed',
//           createdAt: mockTask.createdAt,
//         );
//         when(mockUcFilterTask.call(params: any))
//             .thenAnswer((_) async => [completedTask]);

//         final expectedStates = [
//           const TaskState(filterStatus: "Completadas"),
//           TaskState(taskList: [completedTask]),
//         ];

//         expectLater(
//           taskBloc.stream,
//           emitsInOrder(expectedStates),
//         );

//         taskBloc
//             .add(const OnChangeFilterStatusEvent(filterStatus: "Completadas"));
//       });
//     });
//   });
// }
