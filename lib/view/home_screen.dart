import 'package:e_menu/model/menu_model.dart';
import 'package:e_menu/view/recent_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/cart_controller.dart';
import '../controller/home_controller.dart';
import '../main.dart';
import '../model/final_list.dart';
import 'cart_screen.dart';
import 'favourite_screen.dart';
import 'menu_screen.dart';
import 'package:coupon_uikit/coupon_uikit.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeController homeController =Get.put(HomeController());
  CartController cartController =Get.put(CartController());
  var data = Get.arguments;

  var valueSearch = TextEditingController();



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
          bottomNavigationBar: Obx(()=>
              Container(
                height: 60.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(26.0),
                    topRight: Radius.circular(26.0),
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: const Color.fromRGBO(26, 147, 111, 1),
                    selectedFontSize: 12.0,
                    onTap: (index){
                      homeController.currentIndex.value=index;
                    },
                    currentIndex: homeController.currentIndex.value,
                    items:  [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.restaurant),
                        label: '7'.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.replay),
                        label: '8'.tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.military_tech_sharp),
                        label: '9'.tr,
                      ),
                    ],
                  ),

                ),
              ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${'5'.tr} ${sharedPref.getString('name')}!',
                      style: GoogleFonts.alikeAngular(
                        color: Colors.white,
                        fontSize:17.sp,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                  Row(
                    children: [
                      Text(
                           "Foodies",
                          style: GoogleFonts.almarai(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          )
                      ),
                      const Spacer(),
                      Stack(
                        alignment:Alignment.bottomRight ,
                        children: [
                          IconButton(
                            onPressed: (){
                              // cartController.basket.forEach((element) {  //transfer id from basket list to final list
                              //   cartController.finalList.add(FinalList(id: element.id,qty:1));
                              // });
                              Get.to(CartScreen());
                            },
                            icon:const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 32.0,
                            ),
                          ),
                          Positioned(bottom: 8.0, right: 6.0,
                            child: CircleAvatar(
                              radius: 7.0,
                              backgroundColor: Colors.red,
                              child:  GetBuilder <CartController>( //update when add product to cart
                                builder: (controller)=>
                                    Text(
                                      '${cartController.count}',
                                      style: const TextStyle(
                                          color:Colors.white,
                                          fontSize: 12.0
                                      ),
                                    ),
                              ),

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  TextFormField(
                      controller: valueSearch,
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey
                      ),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              width: 1.0,
                              color:  Color.fromRGBO(0, 61, 45, 1),
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.tune_outlined  ,
                          ),
                          hintText: '6'.tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          prefixIcon: IconButton(
                            onPressed: (){},
                            icon: const Icon(
                              Icons.search,
                              color: Color.fromRGBO(0, 61, 45, 1),
                              size: 28.0,
                            ),
                          )
                      ),
                      // onChanged: (value)
                      // {
                      //
                      //   final suggestion = cartController.basket.where((element) {
                      //     final itemName =element.name!.toLowerCase();
                      //     final input = value.toLowerCase();
                      //
                      //     return itemName.contains(input);
                      //   }).toList();
                      //   cartController.menuCart=suggestion;
                      //   cartController.setState();
                      // },
                    ),
                  const SizedBox(height: 8.0),
                  ClipPath(
                    clipper: const CouponClipper(
                      curvePosition: 60.0,
                    ),
                    child: Container(
                     height: 14.h,
                     color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get Real Discount On',
                                  style: GoogleFonts.arimaMadurai(
                                    fontSize: 16.0
                                  ),
                                ),
                                Text(
                                  'Your Pill By Using',
                                  style:  GoogleFonts.arimaMadurai(
                                      fontSize: 16.0
                                  ),
                                ),
                                Text(
                                  'Your Points',
                                  style:  GoogleFonts.arimaMadurai(
                                      fontSize: 16.0
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(width: 11.w,),
                          Container(
                            height: 11.h,
                            width: 27.w,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(26, 147, 111, 1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                      '47'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ),
                                GetX<HomeController>(
                                  builder:(controller)=>
                                      Expanded(
                                        child: Text(
                                           '${controller.customerPoints.value}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                ),
                                  Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                                  child: Text(
                                      '48'.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Expanded(
                    child: Obx(() => IndexedStack(
                      index: homeController.currentIndex.value,
                      children: [
                        MenuScreen(),
                        RecentScreen(),
                        FavouriteScreen(),
                      ],
                    )),
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
