import 'package:flutter/material.dart';

import './app_colors.dart';

final ThemeData themes = ThemeData(
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
  listTileTheme: const ListTileThemeData(),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: AppColors.red),
  appBarTheme: const AppBarTheme(
    actionsIconTheme: IconThemeData(color: AppColors.yellowFavoriteButton),
    iconTheme: IconThemeData(color: AppColors.white),
    backgroundColor: AppColors.darkRed,
    titleTextStyle: TextStyle(
      color: AppColors.white,
      fontSize: 22,
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 11,
      color: AppColors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      color: AppColors.white,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      color: AppColors.white,
      overflow: TextOverflow.ellipsis,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      color: AppColors.white,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontSize: 21,
      color: AppColors.white,
      fontWeight: FontWeight.w800,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);
