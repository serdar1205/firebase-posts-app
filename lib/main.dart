import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_social_media_app/auth/auth_page.dart';
import 'package:firebase_social_media_app/pages/home_page.dart';
import 'package:firebase_social_media_app/pages/login_page.dart';
import 'package:firebase_social_media_app/pages/profile_page.dart';
import 'package:firebase_social_media_app/pages/users_page.dart';
import 'package:firebase_social_media_app/theme/dark_mode.dart';
import 'package:firebase_social_media_app/theme/light_mode.dart';
import 'package:flutter/material.dart';

import 'auth/login_or_register.dart';
import 'pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyD1wyXklkCIaRTNFhsALunPA8FnJruTTQU",
    appId: "1:824393374408:android:21e629f67511715c3023fd",
    messagingSenderId: "824393374408",
    projectId: "minimal-social-media-7d88a",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: darkMode,
      //darkTheme: darkMode,
      home: const AuthPage(),
      routes: {
        'login_register_page':(context)=>LoginOrRegister(),
        'home_page':(context)=>HomePage(),
        'profile':(context)=>ProfilePage(),
        'users_page':(context)=>UsersPage(),
      },
    );
  }
}
