import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_app/core/network/api_constant.dart';
import 'package:second_app/core/routing/app_route.dart';
import 'package:second_app/core/routing/routes.dart';
import 'package:second_app/core/strings/app_string.dart';
import 'package:second_app/core/theming/cubit_theme.dart';
import 'package:second_app/core/theming/themes.dart';
import 'package:second_app/features/home/provider/home_provider.dart';

class OnBordeingScreen extends StatelessWidget {
  final AppRoute appRoute;
  const OnBordeingScreen({super.key, required this.appRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeProvider()..getData()),
          BlocProvider<ThemeCubit>(
              create: (context) => ThemeCubit()), // ThemeCubit
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: AppString.titleApp,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              initialRoute: ApiConstant.token != null && ApiConstant.token != ""
                  ? Routes.layout
                  : Routes.loginScreen,
              onGenerateRoute: appRoute.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
