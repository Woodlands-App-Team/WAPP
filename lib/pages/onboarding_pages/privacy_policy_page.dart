import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:wapp/pages/onboarding_pages/sign_in_page.dart';
import 'dart:io' show Platform;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

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

  Future<String> getTextData() async {
    String url =
        'https://raw.githubusercontent.com/Woodlands-App-Team/Privacy-Policy/master/Privacy-Policy.md';
    var response = await http.get(Uri.parse(url));
    return response.body;
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
                    child: FutureBuilder(
                      future: getTextData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Markdown(data: snapshot.data as String);
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                        style: GoogleFonts.nunitoSans(
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
