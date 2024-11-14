import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/common/ui/pages/splash.dart';
import 'package:taskapp/modules/home/ui/page/home_page.dart';
import 'package:taskapp/modules/task/ui/pages/pages.dart';

import 'package:taskapp/routes/app_routes.dart';

class AppPages {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return CupertinoPageRoute(builder: (_) => const HomePage());
      case AppRoutes.splash:
        return CupertinoPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.taskDetail:
        return CupertinoPageRoute(
            builder: (_) => const TaskDetails(), settings: settings);
      case AppRoutes.createTask:
        return CupertinoPageRoute(builder: (_) => CreateTaskPage());
      // case AppRoutes.updateTask:
      //   return CupertinoPageRoute(
      //       builder: (_) => const UpdateTaskPage(), settings: settings);

      default:
        return CupertinoPageRoute(builder: (_) => const Scaffold());
    }
  }
}
