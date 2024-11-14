import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:taskapp/common/ui/widgets/custom_text.dart';
import 'package:taskapp/routes/app_routes.dart';
import 'package:taskapp/theme/theme_colors.dart';
import 'package:taskapp/utils/responsive.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () async {
      // in this point you can add functionality for init or validadte sesion
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      backgroundColor: ThemeColors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
          ),
          Center(
            child: ZoomIn(
              duration: const Duration(milliseconds: 4000),
              child: Image.asset(
                "assets/images/logotitle.png",
                width: 200,
              ),
            ),
          ),
          Positioned(
              top: responsive.heightResponsive(90),
              left: responsive.widthResponsive(27),
              child: CustomText(text: "Ten el control de tu futuro"))
        ],
      ),
    );
  }
}
