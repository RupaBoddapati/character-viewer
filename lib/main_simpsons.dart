import 'app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appconfig.dart';
import './provider/character_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  final simpsonsAppConfig = AppConfig(
      appName: 'Simpsons Character Viewer',
      url: 'http://api.duckduckgo.com?q=simpsons+characters&format=json');

  await prefs.setString('url', simpsonsAppConfig.url);
  await prefs.setString('appName', simpsonsAppConfig.appName);

  final app = await initializeApp(simpsonsAppConfig);

  runApp(ChangeNotifierProvider(
    create: (context) => CharacterProvider(),
    child: app,
  ));
}
