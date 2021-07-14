import 'package:flutter/material.dart';
import 'package:wapp/constants.dart';
import 'package:delayed_widget/delayed_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
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
            SizedBox(height: 60),
            Hero(
                tag: 'Privacy Policy Button',
                child: Container(
                  width: MediaQuery.of(context).size.width - 120,
                  decoration: BoxDecoration(
                      color: dark_blue,
                      borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton(
                      onPressed: () {
                        print("I have been pressed");
                      },
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
