import 'package:cats/common/constants/app_theme.dart';
import 'package:cats/presentation/pages/cat_detail_screen.dart';
import 'package:cats/presentation/pages/error_screen.dart';
import 'package:cats/presentation/pages/home_screen.dart';
import 'package:cats/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

import 'domain/entities/cat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.configureAppTheme(),
      home: const SplashScreen(),
      routes: {
        'splash': (context) => const SplashScreen(),
        'home': (context) => const HomeScreen(),
        'detail': (context) => CatDetailPage(
            cat: ModalRoute.of(context)!.settings.arguments as Cat),
        'error': ((context) => ErrorScreen())
      },
    );
  }
}
