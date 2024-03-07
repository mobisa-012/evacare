import 'package:evacare_app/core/services/auth_service.dart';
import 'package:evacare_app/screens/sign_up/bloc/signup_bloc.dart';
import 'package:evacare_app/screens/sign_up/widgets/signup_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SignUpBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listenWhen: (_, currState) => currState is SignInTappedState,
        listener: (context, state) {
          AuthService().signInWWithGoogle(context);
        },
        builder: (context, state) {
          return const SignUpContent();
        },
        buildWhen: (_, currState) => currState is SignUpInitial,
      ),
    );
  }
}
