import 'package:evacare_app/core/enum/bottom_bar.dart';
import 'package:evacare_app/screens/bottom_bar/bloc/bottom_bloc.dart';
import 'package:evacare_app/screens/chatpage/chatpage.dart';
import 'package:evacare_app/screens/home/home_page.dart';
import 'package:evacare_app/screens/onboarding/page/onboarding_page.dart';
import 'package:evacare_app/screens/profile/account_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: Colors.lightBlue[300],
            unselectedItemColor: Colors.grey[850],
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_2_fill), label: 'Chat'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_alt_circle), label: 'Me')
            ],
            onTap: (int index) {
              if (index == 0) {
                BlocProvider.of<BottomBarCubit>(context).getBottomBarItem(BottomBarItem.home);
              } else if(index ==1) {
                BlocProvider.of<BottomBarCubit>(context).getBottomBarItem(BottomBarItem.chat);
              } else if(index ==2){
                BlocProvider.of<BottomBarCubit>(context).getBottomBarItem(BottomBarItem.settings);
              }
            },
          );
        },
      ),
      body: BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
          if (state.bottomBarItem == BottomBarItem.home){
            return const HomePage();
          } else if( state.bottomBarItem == BottomBarItem.chat){
            return const ChatPage();
          } else if(state.bottomBarItem == BottomBarItem.settings){
            return const AccountPage();
          }
          return const OnboardingPage();
        },
      ),
    );
  }
}