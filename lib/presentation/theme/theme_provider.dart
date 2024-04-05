import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/theme/app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkTheme = true;
  ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBgColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBgColor,
    ),
  );

  void changeTheme() {
    isDarkTheme = !isDarkTheme;

    theme = ThemeData(
        scaffoldBackgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColr,
        appBarTheme: AppBarTheme(
          backgroundColor:
              isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColr,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor:
              isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColr,
        ));

    notifyListeners();
  }
}
