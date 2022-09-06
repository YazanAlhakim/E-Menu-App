import 'dart:ui';
import 'package:e_menu/main.dart';
import 'package:e_menu/view/waiting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controller/home_controller.dart';
import '../api/crud.dart';
import '../controller/cart_controller.dart';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../controller/qrcode_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  CartController cartController = Get.find();
  HomeController homeController=Get.find();
  Crud crud = Crud();
  QrcodeController qrcodeController=Get.find();




  Future sendCart() async //send cart & customerId & number of table to Database
  {
    cartController.isLoading.value=true;

    var response = await crud.postRequest('${qrcodeController.domainResturant}/api/orderStore', {
      'customerId': sharedPref.getInt('userId').toString(),
      'table': qrcodeController.tableNumber== null ? '0' : qrcodeController.tableNumber,
      'points':cartController.usePointsFlag== true ?'${cartController.usePoint!.round()}' : '0',
      'orderList': jsonEncode(cartController.finalList),
    });

    cartController.isLoading.value=false;

    cartController.remainingTime=  await response['time'] / 60 ;

    if ( response['gift'].toString() != "null")
      {
        cartController.gift= true;
        cartController.nameOfGift=  response['gift']['name'];
        cartController.imageOfGift=  response['gift']['image'];

      }
    else
      {
        cartController.gift= false;
      }

    return response;
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Scaffold(
        backgroundColor: const Color.fromRGBO(26, 147, 111, 1),
        body: cartController.isLoading.value==true ? const Center(child: CircularProgressIndicator(color:Color.fromRGBO(0, 61, 45, 1)))
       : SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, top: 28.0),
                  color: const Color.fromRGBO(26, 147, 111, 1),
                  child: Text('Foodies',
                      style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(21, 95, 75, 1),
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(30.0),
                          topEnd: Radius.circular(30.0),
                        )),
                    child: Column(
                      children: [
                        GetBuilder<CartController>(
                          builder: (controller) =>
                              Expanded(
                                flex: 2,
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 20,
                                    );
                                  },
                                itemCount: cartController.basket.length,
                                itemBuilder: (context, i) {
                                  return Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 64.0,
                                            width: 64.0,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(0, 61, 45, 1),
                                            borderRadius:
                                                BorderRadiusDirectional.all(
                                                    Radius.circular(12.0)),
                                          ),
                                        ),
                                          Positioned(
                                          child: ClipOval(
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(
                                                  26), // Image radius
                                              child: Image.network(
                                                cartController.basket[i].image
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          top: 6.0,
                                          left: 6.0,
                                        ),
                                      ],
                                    ),
                                      Expanded(
                                      child: GestureDetector(
                                        child: Column(
                                          children: [
                                            Text(
                                              '${cartController.basket[i].name}',
                                              style: const TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 2),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5),
                                              child: Text(
                                                '${cartController.finalList[i].message}',
                                                style: const TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 15.0,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: (){
                                          Get.dialog(
                                            AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'Your Details',
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(12, 80, 60, 1),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6.0),
                                                  TextFormField(
                                                    controller: cartController.detailsContent,
                                                    decoration: const InputDecoration(
                                                      hintText: "Enter Your Details",
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(color: Color.fromRGBO(12, 80, 60, 1),),
                                                      ),
                                                    ),
                                                    cursorColor: const Color.fromRGBO(12, 80, 60, 1),
                                                  ),
                                                  const SizedBox(height: 12.0),
                                                  MaterialButton(
                                                    child: const Text(
                                                      'Apply',
                                                      style: TextStyle(
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
                                                      cartController.finalList[i].message=cartController.detailsContent.text;
                                                      cartController.setState();
                                                      Get.back();
                                                      cartController.detailsContent.text="";
                                                    },
                                                  ),

                                                ],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadiusDirectional.circular(20.0),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                      Column(
                                      children: [
                                        const SizedBox(height: 8.0),
                                        Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                            color: Colors.white,
                                          )),
                                          child: Row(
                                            children: [
                                              Text(
                                                cartController.basket[i].status=="offer" ?'${cartController.basket[i].priceSale}' : '${cartController.basket[i].price}', //if there is a offer then show price sale else show price
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.0),
                                              ),
                                              const SizedBox(width: 8.0),
                                              GestureDetector(
                                                onTap: () {
                                                  cartController.deleteItemFromCart(cartController.basket[i], cartController.finalList[i].qty);
                                                  cartController.finalList.removeAt(i); // and delete that item from final list
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                  size: 22.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                color: Colors.white,
                                              )),
                                              child: GestureDetector(
                                                onTap: () {
                                                  //decrement qty to specific item
                                                  if (cartController.finalList[i].qty! > 1)
                                                  {
                                                    cartController.finalList[i].qty = cartController.finalList[i].qty! - 1;
                                                    cartController.decrementQty(cartController.basket[i]); //decrease price of item from total price
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 12.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            GetBuilder<CartController>(
                                              builder: (controller) =>
                                                  Text(
                                                '${cartController.finalList[i].qty}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Container(
                                              padding: const EdgeInsets.all(2.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                color: Colors.white,
                                              )),
                                              child: GestureDetector(
                                                onTap: () {//increment qty to specific item
                                                  cartController.finalList[i].qty = cartController.finalList[i].qty! + 1;
                                                  cartController.incrementQty(cartController.basket[i]); //increase price of item to total price
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 12.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const Text(
                          '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(bottom: 50.0, start: 10.0),
                            child: Row(
                              children: [
                                 Expanded(
                                  flex: 3,
                                  child: Text(
                                    '10'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                                GetBuilder<CartController>(
                                  builder: (controller) => Expanded(
                                    child:SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text
                                          (
                                          '${cartController.totalPrice.toInt()}',
                                          style:  TextStyle(
                                            color: cartController.usePointsFlag==true? Colors.grey : Colors.white,
                                            fontSize: 22.0,
                                            decoration:cartController.usePointsFlag==true? TextDecoration.lineThrough : null ,
                                          ),
                                        ),
                                        Visibility(
                                          visible: cartController.usePointsFlag==true? true : false,
                                          child: Text(
                                            '${cartController.sale}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        MaterialButton(
                          child:Text(
                            '11'.tr,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Get.dialog(
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children:  [
                                        Text(
                                        '49'.tr,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(12, 80, 60, 1),
                                        ),
                                      ),
                                       Text(
                                        '50'.tr,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(12, 80, 60, 1),
                                        ),
                                      ),
                                      const SizedBox(height: 18.0,),
                                      GetX<CartController>(
                                        builder:(context)=> Text(
                                          '${cartController.sliderValue.value.round()}',
                                          style: const TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GetX<CartController>(
                                        builder:(context)=>
                                          Slider(
                                            value: cartController.sliderValue.value,
                                            onChanged:(value){
                                              cartController.sliderValue.value=value;
                                            },
                                            min: 0,
                                            max:homeController.customerPoints.value== null ? 0 : double.parse(homeController.customerPoints.value.toString()),
                                            thumbColor: const Color.fromRGBO(12, 80, 60, 1),
                                            activeColor: const Color.fromRGBO(12, 80, 60, 1),
                                            ),
                                      ),
                                      const SizedBox(height: 4.0,),
                                      MaterialButton(
                                        child: const Text(
                                            'Apply',
                                          style: TextStyle(
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
                                          cartController.usePoint=cartController.sliderValue.value.round();
                                          cartController.useDiscount();
                                          Get.back();
                                        },
                                      ),

                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.circular(20.0)
                                  ),
                                ),
                              ),
                            );

                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(20.0),
                          ),
                          color: const Color.fromRGBO(0, 61, 45, 1),
                          padding:  EdgeInsets.symmetric(horizontal: 28.w, vertical: 2.w),
                        ),
                        GetBuilder<CartController>(
                          builder: (controller) => MaterialButton(
                            child:  Text(
                              '12'.tr,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {

                              // if(cartController.totalPrice >= 100000)
                              // {
                              //   homeController.customerPoints.value=homeController.customerPoints.value! + ((cartController.totalPrice/100000).floor());
                              // }

                              if (cartController.basket.isEmpty) {
                                    AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: '16'.tr,
                                    desc: '17'.tr,
                                    descTextStyle: const TextStyle(
                                    fontSize: 16.0,
                                    //  color: Color.fromRGBO(0, 61, 45, 1),
                                    ),
                                    // btnCancelOnPress: () {},
                                    btnOkOnPress: () {
                                    Get.back();
                                    },
                                    btnOkColor: const Color.fromRGBO(21, 95, 75, 1),
                                    ).show();
                              }
                               else
                                 {
                                   await sendCart();


                                   print('asasa ${cartController.finalList}');
                                   cartController.usePointsFlag=false;
                                   cartController.usePoint=0;
                                   cartController.sale=0;
                                   cartController.finalList.clear();

                                   if(cartController.gift==true)
                                   {
                                     Get.dialog(
                                         AlertDialog(
                                           content: Column(
                                             mainAxisSize: MainAxisSize.min,
                                             children:  [
                                               Row(
                                                 children:  [
                                                   Text(
                                                     '52'.tr,
                                                     style: const TextStyle(
                                                       fontSize: 18.0,
                                                       fontWeight: FontWeight.bold,
                                                       color: Colors.red,
                                                     ),
                                                   ),
                                                   Text(
                                                     '53'.tr,
                                                     style: const TextStyle(
                                                       fontSize: 18.0,
                                                       fontWeight: FontWeight.bold,
                                                       color: Color.fromRGBO(0, 61, 45, 1),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(height: 12.0,),
                                               Image.network(
                                                 cartController.imageOfGift!,
                                                 height: 80.0,
                                                 width: 80.0,
                                               ),
                                               const SizedBox(height: 6.0,),
                                               Text(
                                                 cartController.nameOfGift!,
                                                 style: const TextStyle(
                                                   fontSize: 18.0,
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                               ),
                                               const SizedBox(height: 12.0,),
                                               MaterialButton(
                                                 child: const Text(
                                                   'Submit',
                                                   style: TextStyle(
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
                                                   Get.off(WatingScreen());
                                                 },
                                               ),


                                             ],
                                           ),
                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(20.0),
                                           ),
                                         )
                                     );
                                   }

                                   else  {
                                     AwesomeDialog(
                                       context: context,
                                       dialogType: DialogType.SUCCES,
                                       animType: AnimType.BOTTOMSLIDE,
                                       title: '13'.tr,
                                       desc: '14'.tr,
                                       descTextStyle: const TextStyle(
                                         fontSize: 16.0,
                                         //  color: Color.fromRGBO(0, 61, 45, 1),
                                       ),
                                       // btnCancelOnPress: () {},
                                       btnOkOnPress: () {
                                         Get.off(WatingScreen());
                                       },
                                       btnOkColor: const Color.fromRGBO(21, 95, 75, 1),
                                     ).show();
                                   }

                                 }

                              controller.clearBasket();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(20.0),
                            ),
                            color: Colors.white,
                            padding:  EdgeInsets.symmetric(horizontal: 30.w, vertical: 2.w),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
