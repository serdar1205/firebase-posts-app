import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_social_media_app/components/my_button.dart';
import 'package:firebase_social_media_app/components/my_textfield.dart';
import 'package:firebase_social_media_app/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final void Function()? onTap;


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void login() {
    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ));
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (error) {
      //pop loading circle
      Navigator.pop(context);
      displayMessageToUser(error.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              SizedBox(height: 25),
              //app name
              Text(
                'MINIMAL',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 50),

              // email
              MyTextfield(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
              ),
              //password
              SizedBox(height: 10),
              MyTextfield(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              // forgot
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  )
                ],
              ),

              //button
              SizedBox(height: 25),
              MyButton(text: 'Log in', onTap: login),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      '\tRegister here',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
              //register
            ],
          ),
        ),
      ),
    );
  }
}
