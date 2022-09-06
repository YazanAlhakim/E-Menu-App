import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';
import '../controller/qrcode_controller.dart';
import '../localizations/local_controller.dart';
import 'home_screen.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);
  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {

  final QRkey = GlobalKey(debugLabel: 'QR');
  QRViewController?controller;
  Barcode? barcode;
  bool enter=false;

  QrcodeController qrcodeController=Get.put(QrcodeController(),permanent: true);



  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async{
    super.reassemble();
    if(Platform.isAndroid)
    {
      await controller!.pauseCamera();
    }
      await controller!.resumeCamera();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(21, 95, 75, 1),
        bottomOpacity: 0.0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title:  const Text(
          'E-Menu',
          style: TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: QRkey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              cutOutSize: MediaQuery.of(context).size.width*0.7,
              borderWidth: 10.0,
              borderLength: 30.0,
              borderColor: const Color.fromRGBO(0, 61, 45, 1),
              borderRadius: 10.0,
              overlayColor: const Color.fromRGBO(21, 95, 75, 1),
            ),
          ),
          Positioned(top: 6.h,
              child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 18.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                children:   [
                  Text(
                    '36'.tr,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Text(
                    '37'.tr,
                    style: const TextStyle(
                      fontSize: 12,
                    ),

                  ),
                  Text(
                    '38'.tr,
                    style: const TextStyle(
                      fontSize: 12,
                    ),

                  ),


                ],


              )
          )),
          Positioned(bottom:10.h,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 61, 45, 1),
                      borderRadius:BorderRadius.circular(10.0),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {
                        });

                  } ,
                      icon: FutureBuilder<bool?>(
                        future: controller?.getFlashStatus(),
                        builder: (context,snapshot)
                        {
                          if(snapshot.data !=null)
                          {
                            return  Icon( snapshot.data! ? Icons.flash_on : Icons.flash_off,
                              color: Colors.white,
                              size: 34.0,
                            );
                          }
                          else
                          {
                            return Container();
                      }
                    },
                  ),

                ),
              ),
                const SizedBox(width: 70.0,),
                Container(
                  height: 50.0,
                  width: 50.0,
                  //clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 61, 45, 1),
                    borderRadius:BorderRadius.circular(10.0),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await controller?.flipCamera();
                      setState(() {
                      });

                    } ,
                    icon: FutureBuilder(
                      future: controller?.getCameraInfo(),
                      builder: (context,snapshot)
                      {
                        if(snapshot.data !=null)
                        {
                          return  const Icon(Icons.switch_camera,
                            color: Colors.white,
                            size: 34.0,
                          );
                        }
                        else
                        {
                          return Container();
                        }
                      },
                    ),

                  ),
                ),
            ],
          )),
          navigation(barcode),
        ],
      ),

    );
  }


  Widget navigation(Barcode? barcode)
  {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if( barcode != null && enter==false)
      {
        print(barcode.code);
        var qrcode=barcode.code.split("#");
        qrcodeController.domainResturant=qrcode[0];
        qrcodeController.tableNumber=qrcode[1];
        print( 'tableeeeee number  ${qrcodeController.tableNumber}');
        print( qrcodeController.domainResturant);

        enter=true;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()));
      }
    });
    return Container();
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode)=> setState(()=> this.barcode=barcode));
  }
}