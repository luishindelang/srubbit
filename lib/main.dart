import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Fronend/Pages/home.dart';
import 'package:scrubbit/Fronend/Style/app_theme.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiAccount()),
        ChangeNotifierProvider(create: (_) => UiHome()),
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
