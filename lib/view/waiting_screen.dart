import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_menu/controller/cart_controller.dart';
import 'package:e_menu/view/feedback_screen.dart';
import 'package:e_menu/view/home_screen.dart';
import 'package:e_menu/view/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../api/crud.dart';
import '../controller/qrcode_controller.dart';
import '../main.dart';

class WatingScreen extends StatelessWidget {

  CartController cartController=Get.find();
  Crud crud=Crud();
  QrcodeController qrcodeController=Get.find();


  Future rateItem() async
  {
    var response= await crud.postRequest('${qrcodeController.domainResturant}/api/rateStore',
    {
      'customer_id':sharedPref.getInt('userId').toString(),
      'rateList': jsonEncode(cartController.rateList),
    }
    );
    return response;
  }

  Widget setupDialog(BuildContext context)
  {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:  [
        const Text(
          'Rate Your Food',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(12, 80, 60, 1),
          ),
        ),
        const SizedBox(height: 18.0,),
        Container(
          height: 40.h,
          width: double.maxFinite,

          child: ListView.separated(
            shrinkWrap: true,

            itemCount: cartController.rateList.length,
            separatorBuilder:(context,i)
            {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],

                ),
              );
            },
            itemBuilder: (context,i)
            {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                        '${cartController.rateList[i].name}',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    itemSize: 18.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    updateOnDrag: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      cartController.rateList[i].rate=rating;
                    },
                  ),

                ],
              );
            },


          ),
        ),
        MaterialButton(
          child:  Text(
            '27'.tr,
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
          onPressed: ()  {
            print(cartController.rateList);
             rateItem();
            cartController.rateList.clear();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Done',
              desc: 'Thank You For Your Rating',
              descTextStyle: const TextStyle(
                fontSize: 16.0,
                //  color: Color.fromRGBO(0, 61, 45, 1),
              ),
              // btnCancelOnPress: () {},
              btnOkOnPress: () {
                Get.off(HomeScreen());
              },
              btnOkColor: const Color.fromRGBO(21, 95, 75, 1),
            ).show();
          },
        ),

      ],
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )),
          ),
          SafeArea(
                child: SizedBox(
                 width: double.infinity,
                 child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsetsDirectional.only(end: 83.w, top: 2.h),
                      child: IconButton(
                          onPressed: () {
                          Get.off(HomeScreen());
                        },
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                          size: 38.0,
                        )),
                    ),
                    SizedBox(height:6.h),
                    Expanded(
                      child: Container(
                       width: 66.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                              SizedBox(height: 8.h),
                              Text(
                              '19'.tr,
                              style: const TextStyle(
                                fontSize: 25.0,
                                color: Color.fromRGBO(12, 80, 60, 1),
                              ),
                            ),
                              SizedBox(height: 4.h),

                            TweenAnimationBuilder<Duration>(
                              duration:  Duration(minutes:cartController.remainingTime.toInt()),
                              tween: Tween(
                                  begin:  Duration(minutes: cartController.remainingTime.toInt()),
                                  end: Duration.zero),
                              builder: (BuildContext context, Duration value,
                                  Widget? child) {
                                final minutes = value.inMinutes;
                                final seconds = value.inSeconds % 60;
                                return Text('$minutes:$seconds',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(12, 80, 60, 1),
                                        fontSize: 80));
                              },
                              onEnd: () {
                                Get.dialog(
                                  AlertDialog(
                                    content: setupDialog(context),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.circular(20.0),
                                    ),
                                  ),
                                );
                              },

                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Column(
                        children:  [
                            Text(
                            '20'.tr,
                            style:  TextStyle(
                              fontSize: 17.sp,
                              color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 4.0),
                            Text(
                            '21'.tr,
                            style:  TextStyle(
                                fontSize: 17.sp,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Padding(
                            padding:  EdgeInsetsDirectional.only(end: 46.w),
                            child: Text(
                              '22'.tr,
                              style: GoogleFonts.alikeAngular(
                                  fontSize: 14.0,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          SizedBox(height:1.h),
                          MaterialButton(
                            onPressed: (){
                              Get.to(FeedbackScreen());
                            },
                            child:  Text(
                              '23'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color:const Color.fromRGBO(0, 61, 45, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding:  EdgeInsets.symmetric(horizontal:26.w ,vertical: 1.4.h),
                          ),


                        ],
                      ),
                    )
              ],
            ),
          )
          ),
        ],
      ),
    );
  }
}
