import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:taskapp/common/constants/app_size.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/modules/task/controller/bloc/task_bloc.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
import 'package:taskapp/modules/task/ui/pages/task_details.dart';
import 'package:taskapp/theme/theme_colors.dart';

class CreateTaskForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final Task? task;
  final bool? isUpdate;
  final BoxConstraints constraints;
  final Function()? onConfirmCreate;
  final Function()? onConfirmEdit;

  const CreateTaskForm(
      {super.key,
      required this.formKey,
      this.task,
      this.isUpdate,
      this.onConfirmCreate,
      this.onConfirmEdit,
      required this.constraints});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return FormBuilder(
            key: formKey,
            child: Center(
              child: LayoutBuilder(builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      FormBuilderField(
                          builder: (context) {
                            return const SizedBox.shrink();
                          },
                          initialValue: task?.id,
                          name: "id"),
                      FormBuilderField(
                          builder: (context) {
                            return const SizedBox.shrink();
                          },
                          initialValue: task?.createdAt,
                          name: "createdAt"),
                      gapH16,
                      FormBuilderField(
                          builder: (context) {
                            return const SizedBox.shrink();
                          },
                          initialValue: task?.status,
                          name: "status"),
                      gapH16,
                      SizedBox(
                        width: constraints.maxWidth * 0.9,
                        child: Column(
                          children: [
                            CustomRoundedTextFormField(
                              name: 'title',
                              hintText: 'Titulo de la tarea',
                              iconRoute: null,
                              errorText: 'El titulo de la tarea es requerido.',
                              maxWidth: constraints.maxWidth * 0.9,
                              maxHeight: constraints.maxHeight * 0.1,
                              maxLines: 1,
                              initialValue: task?.title,
                              isFilled: true,
                            ),
                            gapH16,
                            CustomRoundedTextFormField(
                              name: 'description',
                              hintText: 'Descripción de la tarea',
                              iconRoute: null,
                              errorText:
                                  "La description de la tarea es requerida",
                              maxWidth: constraints.maxWidth * 0.9,
                              maxLines: 6,
                              maxHeight: constraints.maxHeight * 0.5,
                              initialValue: task?.description,
                            ),
                            gapH16,
                            if (isUpdate != null && task != null)
                              LabelStatus(
                                task: task!,
                              ),
                            gapH16,
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: CustomButton(
                                buttonSize:
                                    Size(constraints.maxWidth * 0.9, 50),
                                color: ThemeColors.primary,
                                elevation: 1,
                                textSize: 18,
                                textWeight: FontWeight.w500,
                                textColor: ThemeColors.white,
                                text: isUpdate != null
                                    ? "Actualizar Tarea"
                                    : "Crear Tarea",
                                borderRadius: BorderRadius.circular(10),
                                onPressed: () {
                                  final isValid =
                                      formKey.currentState?.saveAndValidate() ??
                                          false;

                                  if (isValid) {
                                    if (onConfirmCreate != null) {
                                      onConfirmCreate!();
                                    }
                                    if (onConfirmEdit != null) {
                                      onConfirmEdit!();
                                    }
                                  } else {
                                    debugPrint(
                                        "Formulario no válido, verifica los campos.");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
