import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
class ProductDetails extends StatelessWidget {

   var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromRGBO(21, 95, 75, 1),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.only(bottomEnd:Radius.circular(70.0),bottomStart: Radius.circular(70.0))
                  ),
                  child:Column(
                    children: [
                      Padding(
                        padding:  EdgeInsetsDirectional.only(top: 1.h,start: 1.w),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_sharp,
                                color: Color.fromRGBO(21, 95, 75, 1),
                                size: 38.0,
                              ),
                            ),
                          ],

                        ),
                      ) ,
                      Expanded(
                        flex: 6,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(114), // Image radius
                            child: Image.network(
                              '${data[4]}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${data[0]}',
                          style: GoogleFonts.alikeAngular(
                            fontSize: 26.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              'by',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(21, 95, 75, 1),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: Text(
                                  'fodies',
                                  style: GoogleFonts.alikeAngular(
                                    fontSize: 14.sp,
                                    color: Colors.white
                                  )
                              ),
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                        child: RatingBar.builder(
                          initialRating:double.parse(data[3]),
                          minRating: 1,
                          itemSize: 20.sp,
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
                      ),
                    ],
                  ),
                )
            ),
            Expanded(
              flex: 5,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 38.0,
                            width: 158.0,
                            decoration: const BoxDecoration(
                              color:  Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 38.0,vertical:6.0 ),
                            decoration: const BoxDecoration(
                              color:  Color.fromRGBO(21, 95, 75, 1),
                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: const Text(
                              'DETAILS',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Expanded(
                        child: Container(
                           // height: 20.h,
                            width: 84.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(top: 12.0,start:  16.0),
                            child: Text(
                              '${data[2]}',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.visible,
                              style:  TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                          ),
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                )
            ),
            Expanded(
              child: Container(
                height: 60.0,
                width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight:  Radius.circular(20.0))
                    ),
                child: Row(
                  children:  [
                    const Padding(
                      padding: EdgeInsets.only(left: 48.0,right: 172.0),
                      child: Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color:  Color.fromRGBO(21, 95, 75, 1),
                        ),
                      ),
                    ),
                    Text(
                      '${data[1]}SP',
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color:  Color.fromRGBO(21, 95, 75, 1),

                      ),
                    ),
                  ],
                ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
