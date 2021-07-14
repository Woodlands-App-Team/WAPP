import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:wapp/pages/home.dart';
import 'package:wapp/pages/onboarding_pages/landing_page.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      checkFirstSeen();
    });
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => new Home()));
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
