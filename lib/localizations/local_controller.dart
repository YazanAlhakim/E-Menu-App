import 'package:e_menu/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyLocalController extends GetxController

{

  Locale? language =  sharedPref.getString("lang") == null ? Get.deviceLocale //when install App
      : Locale(sharedPref.getString("lang").toString()); //change language from button

  void changeLanguage(String codeLang)
  {
    Locale locale=Locale(codeLang);
    sharedPref.setString("lang", codeLang);
    Get.updateLocale(locale);
  }
}