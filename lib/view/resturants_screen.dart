
import 'package:e_menu/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../api/crud.dart';
import '../controller/qrcode_controller.dart';
import '../main.dart';
import 'choose_type_order_screen.dart';

class ResturantsScreen extends StatelessWidget {
   ResturantsScreen({Key? key}) : super(key: key);

  Crud crud=Crud();
  QrcodeController qrcodeController=Get.put(QrcodeController(),permanent: true);
  
  Future getRestaurants () async
  {
    var response = await crud.getRequest('https://e-menu-admin.herokuapp.com/api/restaurants');
    return response;
  }
  
  
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
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Text(
                    '45'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  const SizedBox(height: 4.0,),
                     Text(
                    '46'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                    ),
                  ),
                  const SizedBox(height: 30.0,),
                  FutureBuilder(
                    future: getRestaurants(),
                    builder: (BuildContext context , AsyncSnapshot snapshot)
                    {
                    if(snapshot.hasData) {

                      return Expanded(
                        child: Center(
                          child: Container(
                            width: 90.w,

                            child: ListView.separated(
                              separatorBuilder: (context,i)
                              {
                                return const SizedBox(height: 26.0,);
                              },
                              itemCount: snapshot.data.length,
                              itemBuilder: (context,i)
                              {
                                return GestureDetector(
                                  onTap: (){
                                     qrcodeController.domainResturant=snapshot.data[i]['domain'];
                                    Get.off(()=>HomeScreen(),arguments: [snapshot.data[i]['name']]);
                                  },
                                  child: Container(
                                    height: 20.h,
                                    decoration:  BoxDecoration(
                                      color: const Color.fromRGBO(0, 61, 45, 1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${snapshot.data[i]['name']}',
                                        style:  TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );

                    }


                    if(snapshot.connectionState== ConnectionState.waiting)
                    {
                      return const Center (child: CircularProgressIndicator(color: Color.fromRGBO(0, 61, 45, 1),));
                    }
                    return const Center (child: CircularProgressIndicator());


                    },

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
