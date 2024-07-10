import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../data/colors.dart';
import 'getStartedPage.dart';
import 'OnBoardoingPages/page1.dart';
import 'OnBoardoingPages/page2.dart';
import 'OnBoardoingPages/page3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController indicateController = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView(
            controller: indicateController,
            onPageChanged: (value) {
              setState(() {
                onLastPage = (value == 2);
              });
            },
            children: const [
              Page1(),
              Page2(),
              Page3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    indicateController.jumpToPage(2);
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(color: AppColors.text),
                  ),
                ),
                SmoothPageIndicator(
                  controller: indicateController,
                  count: 3,
                  effect: WormEffect(
                    dotColor: AppColors.primary,
                    activeDotColor: AppColors.secondary,
                  ),
                ),
                onLastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.push( context,
                              MaterialPageRoute(builder: (context) => GetStarted()),
                            );
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(color: AppColors.text),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          indicateController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(color: AppColors.text),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
