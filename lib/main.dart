import 'package:demo_valorant/core/injectors/injector.dart';
import 'package:demo_valorant/features/home/presentation/pages/home_page.dart';
import 'package:demo_valorant/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:demo_valorant/core/config/env_config.dart';
import 'package:verse_ds/theme/verse_theme.dart';

void main() {
  initDependencies();
  debugPrint('Running in ${EnvConfig.debugMode ? 'DEBUG' : 'RELEASE'} mode');
  debugPrint('App Title: ${EnvConfig.appTitle}');
  debugPrint('API URL: ${EnvConfig.apiUrl}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Valorant',
      theme: VerseTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
