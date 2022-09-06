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

class FavouriteScreen extends StatelessWidget {
   FavouriteScreen({Key? key}) : super(key: key);

  Crud crud=Crud();
  CartController cartController =Get.put(CartController());
   QrcodeController qrcodeController=Get.find();

  Future getRecommend() async{
    var response = await crud.getRequest(
        '${qrcodeController.domainResturant}/api/random5/${sharedPref.getInt('userId').toString()}'
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: getRecommend(),
            builder: (BuildContext context,AsyncSnapshot snapshot)
            {
              if(snapshot.hasData)
              {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.w,
                      mainAxisSpacing: 30.0,
                      mainAxisExtent: 246.0,

                    ),
                    itemCount:snapshot.data.length,
                    itemBuilder:(context,i)
                    {
                      return  GestureDetector(
                        onTap: (){
                          // Get.to(()=>ProductDetails(),arguments: [snapshot.data['menu'][i]['name'],snapshot.data['menu'][i]['price'],snapshot.data['menu'][i]['details'],snapshot.data['menu'][i]['rate'],snapshot.data['menu'][i]['image'],]);
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

                                // Visibility(
                                //   visible: sharedPref.getString('lang')=="ar" ? true : false,
                                //   child: const Positioned(
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
                                // ),
                              ],
                            ),
                            Container(
                              decoration:  BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(snapshot.data[i]['status']=='offer'? 132.0 : 30.0) ,bottomStart: Radius.circular(30.0),topStart: Radius.circular(100.0),topEnd: Radius.circular(100.0)),

                              ),
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(50), // Image radius
                                      child: Image.network(
                                        MenuModel.fromJson(snapshot.data[i]).image.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height:14),
                                  Text(
                                    '${MenuModel.fromJson(snapshot.data[i]).name}',
                                    style: GoogleFonts.alikeAngular(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox( height:16),
                                  // Visibility(
                                  //    visible: snapshot.data['menu'][i]['status']=='sale' ?true :false,
                                  //    child: Container(
                                  //     padding: const EdgeInsetsDirectional.all(2.0),
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.red,
                                  //       borderRadius: BorderRadius.circular(8.0),
                                  //       boxShadow: const [
                                  //         BoxShadow(
                                  //             color: Colors.black45,
                                  //             offset: Offset(0.0,3.0),
                                  //             spreadRadius: 0.0,
                                  //             blurRadius: 1.0
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     child: const Text(
                                  //       'Offer',
                                  //       style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 12.0
                                  //       ),
                                  //     ),
                                  // ),
                                  //  ),
                                  RatingBar.builder(
                                    initialRating:double.parse(MenuModel.fromJson(snapshot.data[i]).rate.toString()),
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
                                  SizedBox(height:MenuModel.fromJson(snapshot.data[i]).status=='offer'? 6.0 : 12.0),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsetsDirectional.only(start:MenuModel.fromJson(snapshot.data[i]).status=='offer'? 20.0 : 32.0,top:MenuModel.fromJson(snapshot.data[i]).status=='offer'? 12.0 : 10.0),
                                        child: Column(
                                          children: [
                                            Visibility(
                                              visible:MenuModel.fromJson(snapshot.data[i]).status=='offer' ? true : false,
                                              child: Text(
                                                '${MenuModel.fromJson(snapshot.data[i]).priceSale}SP',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.italic
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsetsDirectional.only(bottom:MenuModel.fromJson(snapshot.data[i]).status=='offer'? 4.0 : 12.0),
                                              child: Text(
                                                '${MenuModel.fromJson(snapshot.data[i]).price}SP',
                                                style:  TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.italic,
                                                  decoration:MenuModel.fromJson(snapshot.data[i]).status=='offer'?TextDecoration.lineThrough : null,
                                                  color:MenuModel.fromJson(snapshot.data[i]).status=='offer'? Colors.grey : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:  EdgeInsetsDirectional.only(start: MenuModel.fromJson(snapshot.data[i]).status=='offer'?2.0 : 10.0,bottom:MenuModel.fromJson(snapshot.data[i]).status=='offer'? 6.0 : 0.0 ),
                                          child: IconButton(
                                            onPressed: (){
                                              if(cartController.basket.any((element) => element.id == snapshot.data[i]['id']))
                                              {
                                                Fluttertoast.showToast(
                                                  msg: '${snapshot.data[i]['name']} Already Exist',
                                                  gravity: ToastGravity.SNACKBAR,
                                                  timeInSecForIosWeb: 2,
                                                  backgroundColor:Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              }
                                              else{
                                                cartController.add(MenuModel.fromJson(snapshot.data[i]));
                                                Fluttertoast.showToast(
                                                  msg: '${snapshot.data[i]['name']} has been added to cart',
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
                return const Center (child: CircularProgressIndicator());
              }
              return const Center (child: CircularProgressIndicator());
            }
        ),
      ],
    );
  }
}
