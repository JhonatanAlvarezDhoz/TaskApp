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
    on<OnCreateTaskEvent>(_onCreateTask);
  }

  Future<void> _onCreateTask(
      OnCreateTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(taskStatus: TaskStatus.loading));
    _validateForm(event.taskFormKey, emit);

    Map<String, dynamic>? formValues = event.taskFormKey.currentState?.value;
    log(formValues.toString());

    try {
      if (formValues != null) {
        final Task task = TaskBlocHelpres.changeFormValueToTask(formValues);

        final created =
            await ucCreateTask.call(params: UcCreateTaskParams(task: task));
        if (created) {
          emit(state.copyWith(
            taskStatus: TaskStatus.created,
            message: "Tarea Creada conExito",
          ));
        }
        emit(state.copyWith(taskStatus: TaskStatus.initial));
      } else {
        emit(state.copyWith(
            taskStatus: TaskStatus.error,
            errorMessage:
                "Ups!, Ocurrio un error al crear evento. intente mas tarde"));
      }
    } catch (e) {
      log("Created event ${e.toString()}");
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
