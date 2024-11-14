import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:taskapp/common/ui/widgets/custom_snackbar.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/modules/task/controller/bloc/task_bloc.dart';
import 'package:taskapp/modules/task/ui/widgets/widgets.dart';
import 'package:taskapp/routes/app_routes.dart';
import 'package:taskapp/theme/theme_colors.dart';

class CreateTaskPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> createTaskFormKey =
      GlobalKey<FormBuilderState>();

  CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Crear tarea",
          fontSize: 18,
          color: ThemeColors.primary,
        ),
      ),
      body: LayoutBuilder(builder: (context, constrains) {
        return BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state.taskStatus == TaskStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  color: Colors.red.withOpacity(0.7),
                  duration: const Duration(seconds: 3),
                ),
              );
            }

            if (state.taskStatus == TaskStatus.created) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  color: Colors.green.withOpacity(0.7),
                  duration: const Duration(seconds: 3),
                ),
              );

              Future.delayed(
                  const Duration(milliseconds: 500),
                  () =>
                      Navigator.pushReplacementNamed(context, AppRoutes.home));
            }
          },
          builder: (context, state) {
            return state.taskStatus == TaskStatus.loading
                ? SizedBox(
                    height: constrains.maxHeight,
                    width: constrains.maxWidth,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    height: constrains.maxHeight,
                    width: constrains.maxWidth,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: CreateTaskForm(
                      formKey: createTaskFormKey,
                      constraints: constrains,
                      onConfirmCreate: () {
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<TaskBloc>(context).add(
                          OnCreateTaskEvent(taskFormKey: createTaskFormKey),
                        );
                      },
                    ),
                  );
          },
        );
      }),
    );
  }
}
