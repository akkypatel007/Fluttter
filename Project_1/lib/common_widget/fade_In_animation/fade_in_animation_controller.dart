//@dart=2.9

import 'package:get/get.dart';

import '../../screen/on_boarding/on_boarding_screen.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs;

  Future startSplashAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(Duration(milliseconds: 3000));
    animate.value = false;
    await Future.delayed(Duration(milliseconds: 2000));
    Get.off(() => OnBoardingScreen(),
        duration: const Duration(milliseconds: 1000),
        transition: Transition.fadeIn);
  }

//Can be used to animate In after calling the next screen.
  Future animationIn() async {
    await Future.delayed(Duration(milliseconds: 500));
    animate.value = true;
  }

  //Can be used to animate Out before calling the next screen.
  Future animationOut() async {
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
