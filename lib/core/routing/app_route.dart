import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/core/screens/layout.dart';
import 'package:second_app/features/login/provider/login_provider.dart';
import 'package:second_app/features/login/ui/login_screen.dart';

import 'routes.dart';

class AppRoute {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginModel(),
            child: const LoginScreen1(),
          ),
        );

      case Routes.layout:
        return MaterialPageRoute(
          builder: (_) => const MyTabScreen(),
        );
      default:
        return null;
    }
  }
}
