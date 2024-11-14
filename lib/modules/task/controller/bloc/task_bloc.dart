import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:isar/isar.dart';
import 'package:taskapp/modules/task/controller/helpers/task_bloc_helpers.dart';
import 'package:taskapp/modules/task/data/models/task.dart';

import 'package:taskapp/modules/task/data/usecase/usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  late Future<Isar> db;

  final UcCreateTask ucCreateTask;
  final UcUpdateTask ucUpdateTask;
  final UcDeleteTask ucDeleteTask;
  final UcChangeStatus ucChangeStatus;
  final UcGetTaskNoParams ucGetTaskNoParams;
  TaskBloc(
      {required this.ucCreateTask,
      required this.ucUpdateTask,
      required this.ucDeleteTask,
      required this.ucChangeStatus,
      required this.ucGetTaskNoParams})
      : super(const TaskState()) {
    on<OnCreateTaskEvent>(_createTask);
    on<OnGetTaskEvent>(_getTask);
    on<OnUpdateTaskEvent>(_updateTask);
  }

  Future<void> _getTask(OnGetTaskEvent event, Emitter<TaskState> emit) async {
    final List<Task> taskList = await ucGetTaskNoParams.call();

    if (taskList.isNotEmpty) {
      emit(state.copyWith(taskList: taskList));
    }
  }

  Future<void> _createTask(
      OnCreateTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(taskStatus: TaskStatus.loading));
    _validateForm(event.taskFormKey, emit);

    Map<String, dynamic>? formValues = event.taskFormKey.currentState?.value;

    try {
      if (formValues != null) {
        final Task task = TaskBlocHelpres.changeFormValueToTask(formValues);

        final created =
            await ucCreateTask.call(params: UcCreateTaskParams(task: task));
        if (created) {
          emit(state.copyWith(
            taskStatus: TaskStatus.created,
            message: "Tarea Creada con Exito",
          ));
        }
        emit(state.copyWith(taskStatus: TaskStatus.initial));
      } else {
        emit(state.copyWith(
            taskStatus: TaskStatus.error,
            errorMessage:
                "Ups!, Ocurrio un error al crear la tarea. intente mas tarde"));
      }
    } catch (e) {
      log("Created task ${e.toString()}");
      emit(state.copyWith(
          taskStatus: TaskStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _updateTask(
      OnUpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(taskStatus: TaskStatus.loading));

    _validateForm(event.taskFormKey, emit);

    Map<String, dynamic>? formValues = event.taskFormKey.currentState?.value;

    try {
      if (formValues != null) {
        final List<dynamic> formList =
            TaskBlocHelpres.changeFormValueToEditTask(formValues);

        final int id = formList[0];
        final Task task = formList[1];

        final updated = await ucUpdateTask.call(
            params: UcUpdateTaskParams(
          taskId: id,
          task: task,
        ));
        if (updated) {
          emit(state.copyWith(
            taskStatus: TaskStatus.updated,
            message: "Tarea actualizada con Exito",
          ));
        }
        emit(state.copyWith(taskStatus: TaskStatus.initial));
      } else {
        emit(state.copyWith(
            taskStatus: TaskStatus.error,
            errorMessage:
                "Ups!, Ocurrio un error al Actualixzar la tarea. intente mas tarde"));
      }
    } catch (e) {
      log("Update Task ${e.toString()}");
      emit(state.copyWith(
          taskStatus: TaskStatus.error, errorMessage: e.toString()));
    }
  }

  void _validateForm(
      GlobalKey<FormBuilderState> taskFormKey, Emitter<TaskState> emit) {
    bool? isFormValid = taskFormKey.currentState?.saveAndValidate();

    if (isFormValid != null && !isFormValid) {
      log("El formulario no es valido");
      emit(state.copyWith(
        taskStatus: TaskStatus.initial,
        errorMessage: "el formulario no es valido",
      ));
      return;
    }
  }
}
