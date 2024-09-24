import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:second_app/core/network/api_constant.dart';
import 'package:second_app/core/routing/app_route.dart';
import 'package:second_app/core/routing/routes.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/core/theming/colors.dart';
import 'package:second_app/features/home/provider/home_provider.dart';

class OnBordeingScreen extends StatelessWidget {
  final AppRoute appRoute;
  const OnBordeingScreen({super.key, required this.appRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: ChangeNotifierProvider(
        create: (context) => HomeProvider()..getData(),
        child: MaterialApp(
          title: AppString.titleApp,
          theme: ThemeData(
            primaryColor: ColorsManager.mainBlue,
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: ApiConstant.token != null && ApiConstant.token != ""
              ? Routes.layout
              : Routes.loginScreen,
          onGenerateRoute: appRoute.generateRoute,
        ),
      ),
    );
  }
}
