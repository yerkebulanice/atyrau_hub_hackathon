// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:atyrau_hub_hackaton/features/info/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'camera_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  void dispose() async {
    super.dispose();
  }

  // Future scanText(){
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => Center(
  //         child: CircularProgressIndicator(),
  //       )
  //   );
  //
  // }

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     if(pickedFile != null) {
  //       _image = pickedFile;
  //     } else {
  //       print('No image selected');
  //     }
  //   });
  // }

  // _startScan() async {
  //   List<OcrText> list;
  //
  //   try{
  //     list = await FlutterMobileVision.read(
  //       waitTap: true,
  //       fps: 5,
  //       multiple: true,
  //     );
  //     for(OcrText text in list){
  //       print('Value is: ${text.value}');
  //     }
  //   } catch(e) {
  //     print('Error is: $e');
  //   }
  // }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff0000', 'Выйти', true, ScanMode.QR);
      debugPrint(barcodeScanRes);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    checkingValue(barcodeScanRes);
  }

  checkingValue(String _scanBarcode) {
      if (_scanBarcode.contains('https') || _scanBarcode.contains('http')) {
        // return _launchURL(_scanBarcode!);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Info(urlQRCode: _scanBarcode,)));
      } else {
        Fluttertoast.showToast(gravity: ToastGravity.BOTTOM, msg: 'Invalide URL');
      }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('TENGIZCHEVROIL'),
            centerTitle: true,
            backgroundColor: Color(0xff4752b1),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.all(20),
                primary: false,
                shrinkWrap: true,
                children:  [
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CameraScreen()));
                      },
                      child: Column(
                        children: [
                          Icon(Icons.search, size: 40,),
                          Text('Распознать номер машины',textAlign: TextAlign.center,),
                        ],
                      ),
                  ),
                  TextButton(
                      onPressed: (){scanQR();},
                      child: Column(
                        children: [
                          Icon(Icons.qr_code_scanner,size: 40,),
                          Text('Сканировать QR'),
                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}