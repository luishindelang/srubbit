import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Fronend/Pages/home.dart';
import 'package:scrubbit/Fronend/Style/app_theme.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';
import 'package:scrubbit/Fronend/UI-State/ui_month_tasks.dart';
import 'package:scrubbit/Fronend/UI-State/ui_today_tasks.dart';
import 'package:scrubbit/Fronend/UI-State/ui_week_tasks.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiAccount()),
        ChangeNotifierProvider(create: (_) => UiTodayTasks()),
        ChangeNotifierProvider(create: (_) => UiWeekTasks()),
        ChangeNotifierProvider(create: (_) => UiMonthTasks()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        title: "SrubbIt",
        home: const Home(),
      ),
    ),
  );
}
