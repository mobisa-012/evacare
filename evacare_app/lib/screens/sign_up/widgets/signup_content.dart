import 'package:evacare_app/core/const/margins.dart';
import 'package:evacare_app/core/const/path_const.dart';
import 'package:evacare_app/core/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _createImage(context),
          _createSignInButton(context)
        ],
      ),
    );
  }

  Widget _createImage(BuildContext context) {
    return Image.asset(PathConstants.logo);
  }

  Widget _createSignInButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('EvaCare',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700
        ),),
        const YMargin(y: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            elevation: 1,
            minimumSize: const Size(300, 80),
              backgroundColor: const Color.fromARGB(255, 5, 107, 196)
              ),
          onPressed: () {
            AuthService().signInWWithGoogle(context);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.facebook),
              Text(
                'Continue',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),),
            ],
          ),
        ),
      ],
    );
  }
}
