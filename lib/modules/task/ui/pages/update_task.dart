import 'package:flutter/material.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';

class UpdateTaskPage extends StatelessWidget {
  const UpdateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Modificar Tarea"),
      ),
    );
  }
}
