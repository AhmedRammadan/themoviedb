import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/screens/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SceneNow',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
