import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:taskapp/common/constants/app_size.dart';
import 'package:taskapp/common/constants/status_list.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/modules/task/controller/bloc/task_bloc.dart';
import 'package:taskapp/modules/task/data/models/task.dart';
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
                      gapH16,
                      SizedBox(
                        width: constraints.maxWidth * 0.9,
                        child: Column(
                          children: [
                            CustomRoundedTextFormField(
                              name: 'title',
                              hintText: 'Titulo del evento',
                              iconRoute: null,
                              errorText: 'El titulo del evento es requerido.',
                              maxWidth: constraints.maxWidth * 0.9,
                              maxLines: 1,
                              initialValue: task?.title,
                              isFilled: true,
                            ),
                            gapH16,
                            CustomRoundedTextFormField(
                              name: 'description',
                              hintText: 'Descripción del evento',
                              iconRoute: null,
                              errorText:
                                  "La description del evento es requerida",
                              maxWidth: constraints.maxWidth * 0.9,
                              maxLines: 6,
                              maxHeight: constraints.maxHeight * 0.5,
                              initialValue: task?.description,
                            ),
                            gapH16,
                            CustomDropDown(
                              name: "status",
                              elements: StatusList.statusList,
                              elementValueKey: "value",
                              elementChildKey: "key",
                              hint: "Filtrar",
                              width: constraints.maxWidth * 0.9,
                              initialValue: task?.status,
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
                                    ? "Actualizar evento"
                                    : "Crear evento",
                                borderRadius: BorderRadius.circular(10),
                                onPressed: () {
                                  if (onConfirmCreate != null) {
                                    onConfirmCreate!();
                                  }

                                  if (onConfirmEdit != null) {
                                    onConfirmEdit!();
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
