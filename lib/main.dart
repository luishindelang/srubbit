import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/Service/database_service.dart';
import 'package:scrubbit/Fronend/Pages/home.dart';
import 'package:scrubbit/Fronend/Style/app_theme.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbService = await DatabaseService.init();
  debugPaintSizeEnabled = false;
  runApp(
    MultiProvider(
      providers: [
        Provider<DatabaseService>.value(value: dbService),
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
