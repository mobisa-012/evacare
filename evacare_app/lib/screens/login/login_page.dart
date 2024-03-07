import 'package:evacare_app/core/const/margins.dart';
import 'package:evacare_app/core/const/path_const.dart';
import 'package:evacare_app/core/services/auth_service.dart';
import 'package:evacare_app/screens/bottom_bar/page/bottom_bar_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailAuthService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(           
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const YMargin(y: 50),
            Image.asset(PathConstants.logo,
            height: 150,),
            const YMargin(y: 40),
            const Text(
              'EvaCare',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600),
            ),
            const YMargin(y: 80),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(context.screenWidth()/2, 80),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
                  elevation: 2,
                  backgroundColor: const Color.fromARGB(255, 5, 107, 196)
                ),
                onPressed: () {
                  AuthService().signInWWithGoogle(context);
                },
                child: const Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 20,
                  color: Colors.white),
                ),
              ),
            ),

            IconButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BottomTabBar()));
            }, icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
    );
  }
}