import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wapp/pages/onboarding_pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
