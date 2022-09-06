import 'package:e_menu/view/qrcode_screen.dart';
import 'package:e_menu/view/resturants_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../localizations/local_controller.dart';
import 'home_screen.dart';

class ChooseTypeOrder extends StatelessWidget {
   ChooseTypeOrder({Key? key}) : super(key: key);

  MyLocalController localeController =Get.put(MyLocalController());
  RxBool themeValue=false.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(26, 147, 111, 1),
                  Color.fromRGBO(0, 61, 45, 1),
                ],

              )
          ),
        ),
        Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon:  Icon(
                          Icons.settings_sharp,
                          size: 26.sp,
                          color: Colors.white,
                        ),
                        onPressed: (){
                          Get.dialog(
                              AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '41'.tr,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(12, 80, 60, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0,),
                                    MaterialButton(
                                      child:  Text(
                                        '39'.tr,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: const Color.fromRGBO(0, 61, 45, 1),
                                      padding: const EdgeInsets.symmetric(horizontal: 74.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.circular(20.0),
                                      ),
                                      onPressed: (){
                                        localeController.changeLanguage("ar");
                                        Get.back();
                                      },
                                    ),
                                    MaterialButton(
                                      child:  Text(
                                        '40'.tr,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: const Color.fromRGBO(0, 61, 45, 1),
                                      padding: const EdgeInsets.symmetric(horizontal: 74.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.circular(20.0),
                                      ),
                                      onPressed: (){
                                        localeController.changeLanguage("en");


                                        Get.back();
                                      },
                                    ),
                                    // Obx(()=>
                                    //     Switch(
                                    //       value: themeValue.value,
                                    //       onChanged: (value){
                                    //         themeValue.value=value;
                                    //         if(Get.isDarkMode)
                                    //         {
                                    //           print("lighttttt");
                                    //           Get.changeTheme(ThemeData.light());
                                    //         }
                                    //         else{
                                    //           print("darkkkkkkkk");
                                    //           Get.changeTheme(ThemeData.dark());
                                    //         }
                                    //       },
                                    //
                                    //     ),
                                    // ),

                                  ],
                                ),
                              )
                          );

                        },

                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                               Text(
                             '42'.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          MaterialButton(
                            child:  Text(
                              '43'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              color:const Color.fromRGBO(0, 61, 45, 1),
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 2.h),
                              onPressed: (){
                              Get.to(QrCode());
                              }
                          ),
                          SizedBox(height: 4.h,),
                          MaterialButton(
                            child: Text(
                              '44'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            color:const Color.fromRGBO(0, 61, 45, 1),
                            padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 2.h),
                            onPressed: (){
                              Get.to(ResturantsScreen());
                            },

                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
