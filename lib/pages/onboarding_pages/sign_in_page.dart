import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import 'package:wapp/models/provider.dart';
import 'package:provider/provider.dart';
import 'package:wapp/pages/home_page/home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(

        // To make Status bar icons color white in Android devices.
        statusBarIconBrightness: Brightness.light,

        // statusBarBrightness is used to set Status bar icon color in iOS.
        statusBarBrightness: Brightness.light
        // Here light means dark color Status bar icons.

        ));
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser!;
            if ((user.email!.endsWith("@pdsb.net") &&
                    user.displayName!.endsWith("The Woodlands SS")) ||
                user.email!.endsWith("@peelsb.com")) {
              return Home();
            } else {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              final snackBar = SnackBar(
                  content: Text('Please sign in with a PDSB account.'));
              provider.delete();
              provider.logout();
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
              return SignIn();
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("Something went wrong."));
          } else {
            return SignIn();
          }
        },
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

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
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
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
