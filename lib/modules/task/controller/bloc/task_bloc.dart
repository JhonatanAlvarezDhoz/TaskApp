import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:taskapp/modules/task/controller/helpers/task_bloc_helpers.dart';
import 'package:taskapp/modules/task/data/models/task.dart';

import 'package:taskapp/modules/task/data/usecase/usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final UcCreateTask ucCreateTask;
  final UcUpdateTask ucUpdateTask;
  final UcDeleteTask ucDeleteTask;
  final UcChangeStatus ucChangeStatus;
  final UcGetTaskNoParams ucGetTaskNoParams;
  final UcFilterTask ucFilterTask;
  TaskBloc(
      {required this.ucCreateTask,
      required this.ucUpdateTask,
      required this.ucDeleteTask,
      required this.ucChangeStatus,
      required this.ucGetTaskNoParams,
      required this.ucFilterTask})
      : super(const TaskState()) {
    on<OnCreateTaskEvent>(_createTask);
    on<OnGetTaskEvent>(_getTask);
    on<OnUpdateTaskEvent>(_updateTask);
    on<OnDeleteTaskEvent>(_deleteTask);
    on<OnChangeStatusToPending>(_changeStatusToPEnding);
    on<OnChangeStatusToCompleted>(_changeStatusToCompleted);
    on<OnFilterTaskEvent>(_getFilterTask);
    on<OnChangeFilterStatusEvent>(_changeFilterStatus);
  }

  Future<void> _getTask(OnGetTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final List<Task> taskList = await ucGetTaskNoParams.call();

      if (taskList.isNotEmpty) {
        emit(state.copyWith(taskList: taskList));
      } else {
        emit(
          state.copyWith(
              taskList: [],
              taskStatus: TaskStatus.error,
              errorMessage: "Lalista esta vacia"),
        );
      }
    } catch (e) {
      emit(state.copyWith(taskList: state.taskList));
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
          add(OnGetTaskEvent());
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
          add(OnGetTaskEvent());
          emit(state.copyWith(taskStatus: TaskStatus.initial));
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

  Future<void> _deleteTask(
      OnDeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(taskStatus: TaskStatus.loading));
    try {
      final deleted = await ucDeleteTask.call(
          params: UcDeleteTasksParams(taskId: event.taskId));

      if (deleted) {
        log(deleted.toString());
        emit(state.copyWith(
            taskStatus: TaskStatus.deleted,
            message: "Tarea Eliminada con exito."));
        add(OnGetTaskEvent());
        emit(state.copyWith(taskStatus: TaskStatus.initial));
      } else {
        emit(state.copyWith(
            taskStatus: TaskStatus.error,
            errorMessage: "Ocurrio un error, al eliminat la tarea."));
      }
    } catch (e) {
      emit(state.copyWith(
          taskStatus: TaskStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _changeStatusToPEnding(
      OnChangeStatusToPending event, Emitter<TaskState> emit) async {
    emit(state.copyWith(taskStatus: TaskStatus.loading));

    try {
      final changed = await ucChangeStatus.call(
          params: UcChangeStatusParams(
              taskId: event.taskId, status: event.status, endDate: null));

      if (changed) {
        emit(state.copyWith(
            taskStatus: TaskStatus.success,
            message: "Estado de tarea Cambiado a por hacer"));

        add(OnGetTaskEvent());
        emit(state.copyWith(taskStatus: TaskStatus.initial));
      } else {
        emit(state.copyWith(
            taskStatus: TaskStatus.error,
            errorMessage: "No se pudo cambiar el estado de la tarea"));
      }
    } catch (e) {
      emit(state.copyWith(
          taskStatus: TaskStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _changeStatusToCompleted(
      OnChangeStatusToCompleted event, Emitter<TaskState> emit) async {
    emit(state.copyWith(taskStatus: TaskStatus.loading));

    try {
      final changed = await ucChangeStatus.call(
          params: UcChangeStatusParams(
              taskId: event.taskId,
              status: event.status,
              endDate: DateTime.now()));

      if (changed) {
        emit(state.copyWith(
            taskStatus: TaskStatus.success,
            message: "Estado de tarea Cambiado a completado"));

        add(OnGetTaskEvent());
        emit(state.copyWith(taskStatus: TaskStatus.initial));
      } else {
        emit(state.copyWith(
            taskStatus: TaskStatus.error,
            errorMessage: "No se pudo cambiar el estado de la tarea"));
      }
    } catch (e) {
      emit(state.copyWith(
          taskStatus: TaskStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _getFilterTask(
      OnFilterTaskEvent event, Emitter<TaskState> emit) async {
    try {
      final List<Task> filterdTaskList = await ucFilterTask.call(
          params: UcFilterTaskParams(filterString: event.filterStatus));

      if (filterdTaskList.isNotEmpty) {
        emit(state.copyWith(taskList: filterdTaskList));
      } else {
        emit(state.copyWith(taskList: []));
      }
    } catch (e) {
      emit(state.copyWith(taskList: state.taskList));
    }
  }

  Future<void> _changeFilterStatus(
      OnChangeFilterStatusEvent event, Emitter<TaskState> emit) async {
    try {
      emit(state.copyWith(filterStatus: event.filterStatus));

      if (state.filterStatus == "Todas") {
        add(OnGetTaskEvent());
        return;
      }
      if (state.filterStatus == "Pendientes" ||
          state.filterStatus == "Completadas") {
        switch (state.filterStatus) {
          case "Completadas":
            add(const OnFilterTaskEvent(filterStatus: "completed"));

            break;
          case "Pendientes":
            add(const OnFilterTaskEvent(filterStatus: "pending"));

            break;
          default:
        }
      }
    } catch (e) {
      emit(state.copyWith(taskList: state.taskList));
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
