import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:wapp/pages/onboarding_pages/privacy_policy_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height * 0.8),
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                SizedBox(height: 20),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Welcome!',
                      speed: Duration(milliseconds: 250),
                      textStyle: TextStyle(
                          fontSize: 60,
                          color: black,
                          fontWeight: FontWeight.w600),
                      cursor: '',
                    ),
                  ],
                ),
                DelayedWidget(
                  delayDuration: Duration(milliseconds: 1700),
                  child: Text(
                    'to Woodlands',
                    style: TextStyle(
                        fontSize: 30, color: grey, fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: 40),
                DelayedWidget(
                  delayDuration: Duration(milliseconds: 2300),
                  animationDuration: Duration(milliseconds: 500),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1000),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  PrivacyPolicyPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          }));
                    },
                    child: Text("click to continue",
                        style: TextStyle(
                          color: dark_blue,
                          fontSize: 20,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w300,
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
