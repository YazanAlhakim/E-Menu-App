import 'package:e_menu/view/choose_type_order_screen.dart';
import 'package:e_menu/view/qrcode_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../components/components.dart';
import '../controller/cart_controller.dart';
import '../controller/login_controller.dart';
import '../localizations/local_controller.dart';
import '../main.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);


  LoginController loginController=Get.put(LoginController());
  MyLocalController controller =Get.put(MyLocalController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:  const Color.fromRGBO(26, 147, 111, 1),
      body: Stack(
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
          Center(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsetsDirectional.only(top: 62.0),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [
                          RotationTransition(
                            turns:  AlwaysStoppedAnimation(-25 / 360),
                            child: Text('E',
                              style: TextStyle(
                                fontSize: 92.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text('Menu',
                            style: TextStyle(
                              fontSize: 32.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: const BoxDecoration(
                        color:  Color.fromRGBO(0, 61, 45, 1),
                        borderRadius: BorderRadiusDirectional.only(bottomStart:Radius.circular(50.0) ,bottomEnd:Radius.circular(50.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              offset: Offset(
                                  0.0,0.0
                              ),
                              spreadRadius: 12.0,
                              blurRadius: 16.0

                          ),
                        ]
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.only(start: 32.0,top: 90.0),
                      child: Form(
                        key: loginController.formKey,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('1'.tr,
                                    style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                width: 85.w,
                                child: defaultFormField(
                                  controller: loginController.nameContent,
                                  validate: (value)
                                  {
                                    if(value!.isEmpty)
                                    {
                                      return "34".tr;
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  hintText: '2'.tr,
                                  sufix: const Icon(
                                    Icons.person,
                                    color: Color.fromRGBO(0, 61, 45, 1),
                                    size: 24.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              Container(
                                width: 85.w,
                                child: defaultFormField(
                                  controller: loginController.phoneNumberContent,
                                  validate: (value)
                                  {
                                    if(value!.isEmpty)
                                    {
                                      return "35".tr;
                                    }
                                  },
                                  keyboardType: TextInputType.phone,
                                  hintText: '3'.tr,
                                  sufix: const Icon(
                                    Icons.phone,
                                    color: Color.fromRGBO(0, 61, 45, 1),
                                    size: 24.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28.0),
                              MaterialButton(
                                onPressed: (){
                                  if(loginController.formKey.currentState!.validate())
                                  {
                                    sharedPref.setString('login', 'done');
                                    sharedPref.setString('name', loginController.nameContent.text);
                                    sharedPref.setString('phoneNumber', loginController.phoneNumberContent.text.toString());
                                    Get.off(()=> ChooseTypeOrder());
                                  }

                                },
                                child:  Text(
                                  '4'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                color:  const Color.fromRGBO(0, 61, 45, 1),
                                minWidth: 350.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 42.0,

                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '51'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Container(
                        height: 1.0,
                        width: 30.w,
                        color:Colors.black54,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: 12.0),
                          child: GestureDetector(
                              onTap: (){
                                controller.changeLanguage("ar");
                              },
                              child:  Text(
                                  "39".tr,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11.sp,
                                ),

                              ),
                            ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                            onTap: (){
                              controller.changeLanguage("en");
                            },
                            child:  Text(
                                "40".tr,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11.sp,
                              ),
                            ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
