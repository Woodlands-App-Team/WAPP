import 'package:wapp/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:wapp/pages/onboarding_pages/sign_in_page.dart';
import 'dart:io' show Platform;

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPage createState() => _PrivacyPolicyPage();
}

class _PrivacyPolicyPage extends State<PrivacyPolicyPage> {
  bool agree = false;
  final bool isIOS = Platform.isIOS;
  @override
  void initState() {
    agree = false;
    super.initState();
  }

  Future changeAgreeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen privacy policy', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: light_blue,
        body: Container(
          alignment: Alignment.center,
          color: white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  width:
                      MediaQuery.of(context).size.width - (isIOS ? 220 : 230),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                SizedBox(
                  height: isIOS ? 40 : 20,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: grey),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: isIOS ? 400 : 300,
                    child: CupertinoScrollbar(
                      child: ListView(
                          physics: BouncingScrollPhysics(),
                          dragStartBehavior: DragStartBehavior.start,
                          padding: EdgeInsets.all(20),
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: '',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 14,
                                    fontFamily: "Nunito Sans",
                                    fontWeight: FontWeight.w300),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Land Acknowledgement',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: "Poppins",
                                      )),
                                  TextSpan(
                                    text:
                                        '\n\nThe land on which The Woodlands Secondary School operates is the territory of the Mississaugas of the Credit First Nation and the traditional homeland of the Anishinaabe, Wendat, and Haudenosaunee nations. This territory is covered by the Upper Canada Treaties and is within the lands protected by the "Dish with One Spoon" wampum agreement.\n\nToday, this place is still home to many First Nations, Métis, and Inuit peoples and we are grateful to have the opportunity to live and work on this land.\n\n',
                                  ),
                                  TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: "Poppins",
                                      )),
                                  TextSpan(
                                      text: '\n\nLast updated July 14, 2021'),
                                  TextSpan(
                                      text:
                                          '\n\nIF YOU DO NOT AGREE WITH THE TERMS OF THIS PRIVACY POLICY, PLEASE DO NOT ACCESS THE APPLICATION.'),
                                  TextSpan(
                                      text:
                                          '\n\nThe Woodlands Secondary School (“we” or “us” or “our”) respects the privacy of our users (“user” or “you”). This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application (the “Application”). Please read this Privacy Policy carefully.'),
                                  TextSpan(
                                      text:
                                          '\n\nWe reserve the right to make changes to this Privacy Policy at any time and for any reason. We will alert you about any changes by updating the “Last updated” date of this Privacy Policy. You are encouraged to periodically review this Privacy Policy to stay informed of updates. You will be deemed to have been made aware of, will be subject to, and will be deemed to have accepted the changes in any revised Privacy Policy by your continued use of the Application after the date such revised Privacy Policy is posted.'),
                                  TextSpan(
                                      text:
                                          '\n\nThis Privacy Policy does not apply to the third-party online/mobile store from which you install the Application or make payments. We are not responsible for any of the data collected by any such third party.'),
                                ],
                              ),
                            )
                          ]),
                    )),
                SizedBox(
                  height: isIOS ? 20 : 15,
                ),
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: dark_blue,
                        checkColor: white,
                        value: agree,
                        onChanged: (value) {
                          setState(() {
                            agree = value!;
                          });
                        },
                      ),
                      Text(
                        'I have read and accept the privacy policy',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: dark_blue,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Hero(
                    tag: 'Privacy Policy Button',
                    child: Container(
                        decoration: BoxDecoration(
                            color: agree ? dark_blue : grey.withOpacity(0.36),
                            borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: TextButton(
                            onPressed: agree
                                ? () {
                                    changeAgreeState();
                                    Navigator.of(context).pushReplacement(
                                        PageRouteBuilder(
                                            transitionDuration:
                                                Duration(milliseconds: 1250),
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                SignInPage(),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              return child;
                                            }));
                                  }
                                : null,
                            child: Text(
                              'Continue to login',
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20),
                            ),
                          ),
                        )),
                  ),
                ]),
              ],
            ),
          ),
        ));
  }
}
