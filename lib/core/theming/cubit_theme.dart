import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/core/network/cach_network.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String themes = 'mo';

  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme(); // استرجاع الثيم عند بدء التطبيق
  }

  void toggleTheme() async {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      await CashNetwork.saveTheme(themes: themes, themeMode: ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
      await CashNetwork.saveTheme(themes: themes, themeMode: ThemeMode.light);
    }
  }

  _loadTheme() {
    final isDark = CashNetwork.getTheme(themes: themes);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
