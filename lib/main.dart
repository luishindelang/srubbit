import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrubbit/Fronend/Pages/home.dart';
import 'package:scrubbit/Fronend/Style/app_theme.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(
    MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      title: "SrubbIt",
      home: const Home(),
    ),
  );
}
