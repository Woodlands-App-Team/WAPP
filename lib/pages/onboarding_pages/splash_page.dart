import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:wapp/pages/onboarding_pages/landing_page.dart';
import 'package:wapp/pages/onboarding_pages/sign_in_page.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 750), () {
      checkFirstSeen();
    });
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seenPrivacyPolicy = (prefs.getBool('seen privacy policy') ?? false);
    bool isFirstAppStartUp = (prefs.getBool('first time') ?? true);

    if (isFirstAppStartUp) {
      FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('first time', false);
    }

    if (seenPrivacyPolicy) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1250),
          pageBuilder: (context, animation, secondaryAnimation) => SignInPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          }));
    } else {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1250),
          pageBuilder: (context, animation, secondaryAnimation) =>
              LandingPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(

        // To make Status bar icons color white in Android devices.
        statusBarIconBrightness: Brightness.light,

        // statusBarBrightness is used to set Status bar icon color in iOS.
        statusBarBrightness: Brightness.light
        // Here light means dark color Status bar icons.

        ));

    return Container(
        color: white,
        child: Center(
            child: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Hero(
            tag: 'logo',
            child: Image.asset('assets/logo.png'),
          ),
        )));
  }
}
