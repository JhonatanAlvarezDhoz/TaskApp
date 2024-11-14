import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:taskapp/routes/app_pages.dart';
import 'package:taskapp/routes/app_routes.dart';
import 'package:taskapp/theme/theme.dart';

import 'package:taskapp/utils/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = await Injector.dependencies();
  runApp(MainAppInjection(
    dependencies: dependencies,
  ));
}

class MainAppInjection extends StatelessWidget {
  final List<SingleChildWidget> dependencies;
  const MainAppInjection({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: dependencies,
      child: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: customTheme,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppPages.routes,
    );
  }
}
