import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wapp/provider.dart';
import 'package:provider/provider.dart';

import './sign_in_page.dart';
import './signed_in_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser!;
            if (user.email!.endsWith("@pdsb.net")) {
              return LoggedIn();
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
