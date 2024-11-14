part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class OnCreateTaskEvent extends TaskEvent {
  final GlobalKey<FormBuilderState> taskFormKey;

  const OnCreateTaskEvent({required this.taskFormKey});
}

class OnUpdateTaskEvent extends TaskEvent {
  final GlobalKey<FormBuilderState> taskFormKey;

  const OnUpdateTaskEvent({required this.taskFormKey});
}

class OnGetTaskEvent extends TaskEvent {}
