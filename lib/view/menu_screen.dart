import 'package:e_menu/controller/cart_controller.dart';
import 'package:e_menu/model/menu_model.dart';
import 'package:e_menu/view/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../api/crud.dart';
import '../controller/home_controller.dart';
import '../controller/login_controller.dart';
import '../controller/qrcode_controller.dart';
import '../main.dart';
import '../model/final_list.dart';
import 'product_detials_screen.dart';

import 'package:flutter/foundation.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);


  Crud crud = Crud();
  LoginController loginController = Get.put(LoginController());
  HomeController homeController = Get.find();
  CartController cartController = Get.put(CartController());
  QrcodeController qrcodeController=Get.find();




  Future getMenu() async
  {
    var response = await crud.postRequest('${qrcodeController.domainResturant}/api/customerStore',
      {
        'name': sharedPref.getString('name'),
        'phone': sharedPref.getString('phoneNumber'),
      },
    );

    sharedPref.setInt ('userId',response['customer_id']);
    homeController.customerPoints.value= await response['customer_points'];

    return response;
  }



  @override
  Widget build(BuildContext context)  {
    return Column(
      children: [
        FutureBuilder (
            future:  getMenu(),
            builder: (BuildContext context,AsyncSnapshot snapshot)
            {
              if(snapshot.hasData)
              {
                sharedPref.setInt('customerPoints', homeController.customerPoints.value!);

                return  Expanded(
                  child: GridView.builder(
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.w,
                        mainAxisSpacing: 30.0,
                        mainAxisExtent: 246.0,

                      ),
                      itemCount:snapshot.data['menu'].length,
                      itemBuilder:(context,i)
                      {

                        return GestureDetector(
                            onTap: (){
                              Get.to(()=>ProductDetails(),arguments: [snapshot.data['menu'][i]['name'],snapshot.data['menu'][i]['price'],snapshot.data['menu'][i]['details'],snapshot.data['menu'][i]['rate'],snapshot.data['menu'][i]['image'],]);
                            },
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(30.0),bottomStart: Radius.circular(30.0),topStart: Radius.circular(100.0),topEnd: Radius.circular(100.0)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black45,
                                                offset: Offset(0.0, 8.0),
                                                spreadRadius: 0.0,
                                                blurRadius: 4.0
                                            ),


                                          ]
                                      ),
                                    ),
                                     const Positioned(
                                        left: 130.0,
                                        top: 222.0,
                                        child:  Text(
                                          'Offer',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    // const Positioned(
                                    //     right: 130.0,
                                    //     top: 222.0,
                                    //     child:  Text(
                                    //       'عرض',
                                    //       style: TextStyle(
                                    //         color: Colors.white,
                                    //         fontSize: 14.0,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ),
                                    //   ),

                                  ],
                                ),
                                Container(
                                  decoration:  BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(snapshot.data['menu'][i]['status']=='offer'? 132.0 : 30.0) ,bottomStart: Radius.circular(30.0),topStart: Radius.circular(100.0),topEnd: Radius.circular(100.0)),

                                  ),
                                  child: Column(
                                    children: [
                                      ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(50), // Image radius
                                          child: Image.network(
                                             MenuModel.fromJson(snapshot.data['menu'][i]).image.toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height:14,),
                                      Text(
                                        '${MenuModel.fromJson(snapshot.data['menu'][i]).name}',
                                        style: GoogleFonts.alikeAngular(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox( height: 16.0),
                                      RatingBar.builder(
                                        initialRating:double.parse(MenuModel.fromJson(snapshot.data['menu'][i]).rate.toString()),
                                        minRating: 1,
                                        itemSize: 20.0,
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
                                          print(rating);
                                        },
                                      ),
                                      SizedBox(height:MenuModel.fromJson(snapshot.data['menu'][i]).status=='offer'? 6.0 : 12.0),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:  EdgeInsetsDirectional.only(start:MenuModel.fromJson(snapshot.data['menu'][i]).status=='offer'? 20.0 : 32.0,top:MenuModel.fromJson(snapshot.data['menu'][i]).status=='offer'? 12.0 : 10.0),
                                            child: Column(
                                              children: [
                                                Visibility(
                                                  visible:MenuModel.fromJson(snapshot.data['menu'][i]).status=='offer' ? true : false,
                                                  child: Text(
                                                    '${MenuModel.fromJson(snapshot.data['menu'][i]).priceSale}SP',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        fontStyle: FontStyle.italic
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:  EdgeInsetsDirectional.only(bottom:MenuModel.fromJson(snapshot.data['menu'][i]).status=='offer'? 4.0 : 12.0),
                                                  child: Text(
                                                    '${MenuModel.fromJson(snapshot.data['menu'][i]).price}SP',
                                                    style:  TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.italic,
                                                      decoration:MenuModel.fromJson(snapshot.data['menu'][i]).status=='offer'?TextDecoration.lineThrough : null,
                                                      color:MenuModel.fromJson(snapshot.data['menu'][i]).status=='offer'? Colors.grey : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:  EdgeInsetsDirectional.only(start: MenuModel.fromJson(snapshot.data['menu'][i]).status=='offer'? 2.0 : 10.0,bottom:MenuModel.fromJson(snapshot.data['menu'][i]).status=='offer'? 8.0 : 0.0),
                                              child: IconButton(
                                                onPressed: ()  {

                                                        if(cartController.basket.any((element) => element.id == snapshot.data['menu'][i]['id']))
                                                        {
                                                          Fluttertoast.showToast(
                                                            msg: '${snapshot.data['menu'][i]['name']} Already Exist',
                                                            gravity: ToastGravity.SNACKBAR,
                                                            timeInSecForIosWeb: 2,
                                                            backgroundColor:Colors.red,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0,
                                                          );
                                                        }
                                                        else{
                                                          cartController.add(MenuModel.fromJson(snapshot.data['menu'][i]));
                                                          Fluttertoast.showToast(
                                                            msg: '${snapshot.data['menu'][i]['name']} has been added to cart',
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.SNACKBAR,
                                                            timeInSecForIosWeb: 2,
                                                            backgroundColor:  const Color.fromRGBO(26, 147, 111, 1),
                                                            textColor: Colors.white,
                                                            fontSize: 16.0,
                                                          );
                                                        }

                                                     },


                                                icon:  const Icon(
                                                  Icons.add,
                                                  size: 28.0,
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),


                                    ],
                                  ),
                                ),

                              ],
                            ),
                          );

                      },


                    ),
                );

              }

              if(snapshot.connectionState== ConnectionState.waiting)
              {
                return const Center (child: CircularProgressIndicator(color: Color.fromRGBO(0, 61, 45, 1),));
              }
              return const Center (child: CircularProgressIndicator());
            }

        ),
      ],
    );
  }
}
