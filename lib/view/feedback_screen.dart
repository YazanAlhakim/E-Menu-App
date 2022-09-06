import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../api/crud.dart';
import '../controller/home_controller.dart';
import '../controller/qrcode_controller.dart';
import '../main.dart';
import 'home_screen.dart';

class FeedbackScreen extends StatelessWidget {
  //const FeedbackScreen({Key? key}) : super(key: key);

  var feedbackContent=TextEditingController();
  Crud crud=Crud();
  QrcodeController qrcodeController=Get.find();
  HomeController homeController =Get.find();
  
  Future sendFeedback() async
  {
    var response =await crud.postRequest('${qrcodeController.domainResturant}/api/feedbackStore',
    {
      'customer_id': sharedPref.getInt('userId').toString(),
      'message' : feedbackContent.text,
    }
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text(
          'Feedback',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0
          ),

        ),
        backgroundColor: const Color.fromRGBO(0, 61, 45, 1),
        toolbarHeight: 70.0,
        elevation: 6.0,
      ),
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
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Container(
                    height: 56.h,
                    width: 92.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                         SizedBox(
                          height: 4.h,
                        ),
                         Text(
                          '24'.tr,
                            style: const TextStyle(
                            fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 61, 45, 1),
                          ),
                        ),
                         SizedBox(height: 5.h,),
                         Padding(
                           padding: EdgeInsetsDirectional.only(end: 42.w),
                           child: Text(
                            '25'.tr,
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(51, 51, 51, 1),
                            ),
                          ),
                        ),
                         SizedBox(height:1.h,),
                         Expanded(
                           child: Container(
                           width:82.w,
                           // height: 500.0,
                           child: TextFormField(
                             controller: feedbackContent,
                             keyboardType: TextInputType.multiline,
                             minLines: 1,
                             maxLines: 2,
                             decoration:  InputDecoration(
                               hintText: '26'.tr,
                               border: InputBorder.none,
                               fillColor: const Color.fromRGBO(217, 217, 217, 1),
                               filled: true,
                               isDense: true,
                               contentPadding: const EdgeInsets.only(bottom: 180.0,left: 12.0,top: 16.0,right: 12.0),
                             ),


                           ),
                         )
                         ),
                         SizedBox(
                          height: 5.h,
                        ),
                         Padding(
                             padding: EdgeInsetsDirectional.only(bottom: 2.h),
                             child:   MaterialButton(
                             onPressed: (){
                               sendFeedback();

                               if(feedbackContent.text.isEmpty)
                               {
                                 AwesomeDialog(
                                   context: context,
                                   dialogType: DialogType.ERROR,
                                   animType: AnimType.BOTTOMSLIDE,
                                   title: '31'.tr,
                                   desc: '32'.tr,
                                   descTextStyle: const TextStyle(
                                     fontSize: 16.0,
                                     //  color: Color.fromRGBO(0, 61, 45, 1),
                                   ),
                                   // btnCancelOnPress: () {},
                                   btnOkOnPress: () {
                                     // Get.back();
                                   },
                                   btnOkColor: const Color.fromRGBO(21, 95, 75, 1),
                                 ).show();
                               }
                               else
                               {
                                 AwesomeDialog(
                                   context: context,
                                   dialogType: DialogType.SUCCES,
                                   animType: AnimType.BOTTOMSLIDE,
                                   title: '28'.tr,
                                   desc:  '29'.tr,
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
                               }
                               feedbackContent.clear();


                             },

                             child:  Text(
                               '27'.tr,
                               style: const TextStyle(
                                 fontSize: 14.0,
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             color:const Color.fromRGBO(0, 61, 45, 1),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(20.0),
                             ),
                             padding:  EdgeInsets.symmetric(horizontal:21.w ,vertical:1.h),
                           ),
                         ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
