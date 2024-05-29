import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_social_media_app/auth/login_or_register.dart';
import 'package:firebase_social_media_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (
          BuildContext context, snapshot
        ) {
          //user is logged
          if (snapshot.hasData) {
            return HomePage();
          }  else{
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
