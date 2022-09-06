import 'package:e_menu/localizations/local.dart';
import 'package:e_menu/localizations/local_controller.dart';
import 'package:e_menu/view/choose_type_order_screen.dart';
import 'package:e_menu/view/login_screen.dart';
import 'package:e_menu/view/qrcode_screen.dart';
import 'package:e_menu/view/resturants_screen.dart';
import 'package:e_menu/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


late SharedPreferences sharedPref;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref= await SharedPreferences.getInstance();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
   MyLocalController controller = Get.put(MyLocalController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType)
            {
              return GetMaterialApp(
                home:SplashScreen(),
                locale: controller.language,
                translations: MyLocal(),
                //theme: ThemeData.light(),
                debugShowCheckedModeBanner: false,
              );
            }
    );

  }
}
