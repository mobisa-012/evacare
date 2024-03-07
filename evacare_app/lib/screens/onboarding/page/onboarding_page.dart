import 'package:evacare_app/core/const/data_const.dart';
import 'package:evacare_app/core/const/margins.dart';
import 'package:evacare_app/screens/login/email_login.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController pageController;
  late int selectedPage;

  @override
  void initState() {
    super.initState();
    selectedPage =0;
    pageController = PageController(initialPage: selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    const pageCount =3;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (page) {
                  setState(() {
                    selectedPage = page;
                  });
                },
                children: DataConst.onboardingTiles,
              )
            ),
            PageViewDotIndicator(
              currentItem: selectedPage, 
              count: pageCount, 
              unselectedColor: const Color.fromARGB(255, 48, 48, 48), 
              selectedColor: const Color.fromARGB(255, 79, 195, 247)
            ),
            const YMargin(y: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 55),
                  backgroundColor: const Color.fromARGB(255, 5, 107, 196),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const EmailLogin()));
              }, 
              child: const Text(
                'Get started',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black
                ),
              )
            ),
            const YMargin(y: 50)
          ],
        ),
      ),
    );
  }
}