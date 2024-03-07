// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evacare_app/core/data/user_data.dart';
import 'package:evacare_app/screens/bottom_bar/page/bottom_bar_page.dart';
import 'package:evacare_app/screens/onboarding/page/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) {
          return const BottomTabBar();
        } else {
          return const OnboardingPage();
        }
      },
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password ,context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      debugPrint('User created: ${userCredential.user!.uid}');
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
        debugPrint('$e');
    }
  }

  signInWWithGoogle(BuildContext context)async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>['email']).signIn();
      if (googleUser == null) {
        // The user canceled the sign-in process.
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Sign in with the credential
      UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
        EvaCareUsers evaCareUsers = EvaCareUsers(
          displayName: authResult.user!.displayName ?? "", 
          email: authResult.user!.email ?? "", 
          uid: authResult.user!.uid
        );
        await saveUserToFirestore(evaCareUsers);
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomTabBar())
        );
        // await showLinkEmailAndPasswordDialog(context);
    } catch (e) {
      debugPrint('Error signing user: $e');
      if (e is FirebaseAuthException) {
    debugPrint('Error code: ${e.code}');
    debugPrint('Error message: ${e.message}');
      }
    }
  }

  Future <void> saveUserToFirestore(EvaCareUsers evaCareUsers) async {
    try {
      await FirebaseFirestore.instance
      .collection('evacare_Users')
      .doc(evaCareUsers.displayName)
      .set({
        'name': evaCareUsers.displayName,
        'email': evaCareUsers.email,
        'uid': evaCareUsers.uid
      });
    } catch (e) {
      debugPrint('Error saving to Firestore $e');
    }
  }

  Future<void> linkEmailAndPassword(String email, String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        await user.linkWithCredential(EmailAuthProvider.credential(email: email, password: password));
        debugPrint('Email and password linked successfully');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Error linking email and password: $e');
    }
    catch (e) {
      debugPrint('Unexpected error: $e');
    }
  }

  Future<void> showLinkEmailAndPasswordDialog(BuildContext context) async {
    final shouldLink = await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text(
          'Link email and password'
        ),
        content: const Text(
          'Would you like to link and existing email and password '
          'with your Google account for easier login in the future?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              )
            ), 
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              )
            ), 
            child: const Text('Link'),
          )
        ],
      )
    );
    if (shouldLink == true) {
      final emailController = TextEditingController();
      final passwordController = TextEditingController();
      final shouldLinkConfirmed = await showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: const Text(
            'Enter email and password'
          ),
          content: Column(
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(                  
                  labelText: 'me@gmail.com',                  
                ),
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(                  
                  labelText: 'Password',                  
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), 
              child: const Text('Cancel')
            ),
            TextButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                await linkEmailAndPassword(email, password);
              }, 
              child: const Text('Link')
            )
          ],
        )
      );
      if (shouldLinkConfirmed == true) {
        debugPrint('Email and password linked succefully');
        // add dialog to show true
      }
    }
  }
}