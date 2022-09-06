import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../main.dart';
import 'choose_type_order_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
          'assets/image/resturant.png',
      ),
      title: Text(
        "E-Menu",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(26, 147, 111, 1),
        ),
      ),
      backgroundColor:  Colors.white,
      showLoader: true,
      loadingText: const Text(
        "Loading...",
        style: TextStyle(
          color: Color.fromRGBO(26, 147, 111, 1),
        ),

      ),
      navigator: sharedPref.getString('login')==null ? LoginScreen() : ChooseTypeOrder(),
      durationInSeconds: 10,
    );
  }
}
