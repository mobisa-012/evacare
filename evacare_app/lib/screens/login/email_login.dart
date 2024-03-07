// ignore_for_file: avoid_print

import 'package:evacare_app/core/const/margins.dart';
import 'package:evacare_app/core/const/path_const.dart';
import 'package:evacare_app/core/services/email_auth.dart';
import 'package:evacare_app/screens/bottom_bar/page/bottom_bar_page.dart';
import 'package:evacare_app/screens/sign_up/page/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final emailAuthService = EmailAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Image.asset(PathConstants.pmom),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'EvaCare',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600),
            ),
            const YMargin(y: 20),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: emailTextField(),
            ),
            const YMargin(y: 20),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Form(
                key: passwordKey,
                child: passwordTextFiled(),
              ),
            ),
            const YMargin(y: 20),
            signInEmailButton(context),
            const YMargin(y: 20),
            signUPRow(context)
          ],
        ),
      ),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
              key: formKey,
              controller: emailController,
              validator: (email) {
                if (email!.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Email..',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    size: 30,
                    color: Colors.blue,
                  )),
              keyboardType: TextInputType.emailAddress,
            );
  }

  TextFormField passwordTextFiled() {
    return TextFormField(
                validator: (password) {
                  final RegExp regExp =
                      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
                  if (!regExp.hasMatch(password!)) {
                    return 'Password must contain at least one letter, one number, and be at least 8 characters long';
                  }
                  return null;
                  // returns null if password is valid
                },
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Password..',
                    prefixIcon: const Icon(
                      Icons.vpn_key,
                      size: 30,
                      color: Colors.blue,
                    )),
                keyboardType: TextInputType.emailAddress,
              );
  }

  Row signUPRow(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account?',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SignUpPage()));
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          );
  }

  ElevatedButton signInEmailButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(context.screenWidth() /2, 70),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
        elevation: 2,
        backgroundColor: Colors.lightBlue
      ),
      onPressed: () {
        try {
          final email = emailController.text;
          final password = passwordController.text;
          emailAuthService.registerUserWithEmailAndPassword(email, password);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const BottomTabBar()));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            // show snackbar
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'User not found. Please sign up to continue')));
          } else if (e.code == 'wrong-password') {
            // wrong password
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'You have entered the wrong password. Please try again')));
          }
        } catch (error) {
          // other errors
          print('Error: $error');
        }
      },
      child: const Text(
        'Sign in',
        style: TextStyle(fontSize: 20,
        color: Colors.white),
      ),
    );
  }

  // bool validatePassword(String password) {
  //   final RegExp regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  //   return regExp.hasMatch(password);
  // }
}
