import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

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
  final wireAppConfig = AppConfig(
      appName: 'The Wire Character Viewer',
      url: 'http://api.duckduckgo.com/?q=the+wire+characters&format=json');

  await prefs.setString('url', wireAppConfig.url);
  await prefs.setString('appName', wireAppConfig.appName);

  final app = await initializeApp(wireAppConfig);

  runApp(ChangeNotifierProvider(
    create: (context) => CharacterProvider(),
    child: app,
  ));
}
