import 'package:character_viewer/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'appconfig.dart';

Future<Widget> initializeApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();
  return MyApp(appConfig: appConfig);
}

class MyApp extends StatelessWidget {
  final AppConfig appConfig;
  const MyApp({super.key, required this.appConfig});

  final TextTheme myTextTheme = const TextTheme(
    headline1: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    // Define more text styles as needed
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: myTextTheme,
          fontFamily: 'Montserrat'),
      home: const MainScreen(),
    );
  }
}
