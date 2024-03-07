import 'package:evacare_app/core/services/email_auth.dart';
import 'package:evacare_app/screens/bottom_bar/bloc/bottom_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomBarCubit>(
      create: (context) => BottomBarCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EvaCare',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: EmailAuthService().handleAuthState(),
      ),
    );
  }
}