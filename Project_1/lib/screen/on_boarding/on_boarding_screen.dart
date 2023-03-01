import 'package:career360/screen/dashboard/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/colors.dart';
import '../../controllers/on_boarding_controller.dart';
import '../welcome_screen/welcome_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final obController = OnBoardingController();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final buttonSize = height * 0.1;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                LiquidSwipe(
                  pages: obController.pages,
                  enableSideReveal: true,
                  liquidController: obController.controller,
                  onPageChangeCallback: obController.OnPageChangedCallback,
                  slideIconWidget: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                  positionSlideIcon: 0.7,
                ),
                Positioned(
                  top: height * 0.05,
                  right: width * 0.05,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelocmePage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: height * 0.065,
                  right: width * 0.40,
                  child: OutlinedButton(
                    onPressed: () => obController.animateToNextSlide(),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.black26),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      foregroundColor: Colors.white,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: tDarkColor, shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                Obx(() => Positioned(
                      bottom: height * 0.05,
                      left: width * 0.40,
                      child: AnimatedSmoothIndicator(
                        count: 3,
                        activeIndex: obController.currentPage.value,
                        effect: const WormEffect(
                          activeDotColor: Color(0xff272727),
                          dotHeight: 5.0,
                        ),
                      ),
                    ))
              ],
            ),
          );
        }
      },
    );
  }
}
