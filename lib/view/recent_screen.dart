import 'package:e_menu/model/recent_list_model.dart';
import 'package:e_menu/view/cart_screen.dart';
import 'package:e_menu/view/product_detials_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../api/crud.dart';
import '../controller/cart_controller.dart';
import '../controller/qrcode_controller.dart';
import '../main.dart';
import '../model/menu_model.dart';

class RecentScreen extends StatelessWidget {
   RecentScreen({Key? key}) : super(key: key);

  Crud crud=Crud();
  CartController cartController =Get.put(CartController());
   QrcodeController qrcodeController=Get.find();

  Future getRecent() async{
    var response = await crud.getRequest(
        '${qrcodeController.domainResturant}/api/orderCustomerView/${sharedPref.getInt('userId').toString()}'
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: getRecent(),
            builder: (BuildContext context,AsyncSnapshot snapshot)
                {
                  if(snapshot.hasData)
                    {
                      return Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context,i)
                          {
                            return const SizedBox(height: 30.0);
                          },
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,i)
                          {
                            return Container(
                              height: 36.h,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(0, 61, 45, 1),
                                borderRadius:
                                BorderRadiusDirectional.all(
                                    Radius.circular(22.0)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(top: 6.0,bottom: 13.0),
                                    child: Text(
                                        snapshot.data[i]['created_at'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,

                                        ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                        separatorBuilder: (context,i)
                                        {
                                          return const SizedBox(height: 10.0);
                                        },
                                        itemBuilder: (context,j)
                                      {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 50.0,
                                                    width: 50.0,
                                                    decoration: const BoxDecoration(
                                                      color:Colors.black38,
                                                      borderRadius:
                                                      BorderRadiusDirectional.all(
                                                          Radius.circular(12.0)),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: ClipOval(
                                                      child: SizedBox.fromSize(
                                                        size: const Size.fromRadius(
                                                            20), // Image radius
                                                        child: Image.network(
                                                          snapshot.data[i]['order'][j]['product']['image']
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
                                                flex: 3,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        snapshot.data[i]['order'][j]['product']['name'],
                                                      style: const TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(height: 4.0,),
                                                    Text(
                                                      snapshot.data[i]['order'][j]['qtu'].toString(),
                                                      style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.white38
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  snapshot.data[i]['order'][j]['product']['status']=="offer" ?  snapshot.data[i]['order'][j]['product']['priceSale'] :snapshot.data[i]['order'][j]['product']['price'],
                                                  style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              GestureDetector(
                                                  child: const Icon(
                                                  Icons.shopping_cart,
                                                  color: Colors.deepOrangeAccent,
                                                  ),
                                                  onTap: (){

                                                    if(cartController.basket.any((element) => element.id == snapshot.data[i]['order'][j]['product_id']))
                                                      {
                                                        Fluttertoast.showToast(
                                                          msg: '${snapshot.data[i]['order'][j]['product']['name']} Already Exist',
                                                          gravity: ToastGravity.SNACKBAR,
                                                          timeInSecForIosWeb: 2,
                                                          backgroundColor:Colors.red,
                                                          textColor: Colors.white,
                                                          fontSize: 16.0,
                                                        );
                                                      }
                                                    else{

                                                      cartController.addFromRecent(RecentListMoudel.fromJson(snapshot.data[i]['order'][j]));
                                                      Fluttertoast.showToast(
                                                        msg: '${snapshot.data[i]['order'][j]['product']['name']} has been added to cart',
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.SNACKBAR,
                                                        timeInSecForIosWeb: 2,
                                                        backgroundColor:  const Color.fromRGBO(26, 147, 111, 1),
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      );


                                                    }

                                                  },
                                                ),

                                            ],
                                          ),
                                        );
                                      },
                                        itemCount: snapshot.data[i]['order'].length,
                                    ),
                                  ),
                                  const Text(
                                    '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(start: 20.0,top: 14,bottom: 12),
                                    child: Row(
                                      children: [
                                         Expanded(
                                          flex: 3,
                                          child: Text(
                                              '10'.tr,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0
                                              ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data[i]['amount'],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 18.0
                                            ),
                                          ),
                                        ),



                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                      );
                    }

                  if(snapshot.connectionState== ConnectionState.waiting)
                  {
                    return const Center (child: CircularProgressIndicator());
                  }
                  return const Center (child: CircularProgressIndicator());
                }
        ),
      ],
    );
  }
}
