import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_social_media_app/components/my_button.dart';
import 'package:firebase_social_media_app/components/my_textfield.dart';
import 'package:firebase_social_media_app/helper/helper_functions.dart';
import 'package:firebase_social_media_app/pages/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final userNameController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void register() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    if (passwordController.text != confirmPasswordController.text) {
      //pop loading circle
      Navigator.pop(context);

      //show error message to user
      displayMessageToUser('Passwords don\'t match', context);
    } else {
      try {
        //create user
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //create a user document and add to firestore
        createUserDocument(userCredential);
        //pop loading circle
        if (context.mounted) {
          Navigator.pop(context);
        }

      } on FirebaseAuthException catch (error) {
        //pop loading circle
        Navigator.pop(context);
        displayMessageToUser(error.code, context);
      }
    }
  }

  //create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
        'password': passwordController.text,
      });
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
              const SizedBox(height: 25),
              //app name
              const Text(
                'MINIMAL',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),

              //name

              MyTextfield(
                hintText: 'Name',
                obscureText: false,
                controller: userNameController,
              ),
              //password
              const SizedBox(height: 10),

              // email
              MyTextfield(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
              ),
              //password
              const SizedBox(height: 10),
              MyTextfield(
                hintText: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),

              //confirm password
              MyTextfield(
                hintText: 'Confirm password',
                obscureText: false,
                controller: confirmPasswordController,
              ),
              // forgot

              //button
              const SizedBox(height: 25),
              MyButton(text: 'Register', onTap: register),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,

                    //     () {
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (context) => LoginPage()));
                    // },
                    child: const Text(
                      '\tLogin here',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
