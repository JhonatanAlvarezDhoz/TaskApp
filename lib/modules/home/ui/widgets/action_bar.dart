import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskapp/common/ui/widgets/widgets.dart';
import 'package:taskapp/modules/home/controller/home_bloc/home_bloc.dart';
import 'package:taskapp/routes/app_routes.dart';
import 'package:taskapp/theme/theme_colors.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    super.key,
    required this.size,
    required this.statusList,
  });

  final Size size;
  final List<Map<String, dynamic>> statusList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width * 0.08,
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 20),
              height: size.height * 0.05,
              width: size.width * 0.4,
              child: CustomDropDown(
                name: "status",
                elements: statusList,
                elementValueKey: "value",
                elementChildKey: "key",
                hint: "Filtrar",
                initialValue: "all",
              ),
            );
          },
        ),
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.createTask),
              icon: SvgPicture.asset(
                "assets/icons/add_task.svg",
                width: 50,
                colorFilter: const ColorFilter.mode(
                  ThemeColors.primary,
                  BlendMode.srcIn,
                ),
              )),
        )
      ],
    );
  }
}
