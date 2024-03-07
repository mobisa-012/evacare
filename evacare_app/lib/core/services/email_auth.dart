// ignore_for_file: avoid_print
import 'package:evacare_app/screens/bottom_bar/page/bottom_bar_page.dart';
import 'package:evacare_app/screens/onboarding/page/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential result = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<User?> registerUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential result = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password ,context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('User created: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign up status'),
              content: const Text('The password provided is too weak'),
              actions: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, 
                child: const Text('Sign up')
                )
              ],
            );
          }
          );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign up status'),
              content: const Text('This account already exists'),
              actions: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, 
                child: const Text('Sign up')
                )
              ],
            );
          }
          );
      }
    } catch (e) {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error: $e'),
          );
        }
        );
        print(e);
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const BottomTabBar();
          } else {
            return const OnboardingPage();
          }
        });
  }
}
