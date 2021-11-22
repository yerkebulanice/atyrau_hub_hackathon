// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:atyrau_hub_hackaton/features/info/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _scanBarcode;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

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

  

  @override
  void dispose (){
    super.dispose();
  }

  checkingValue(String _scanBarcode) {
      if (_scanBarcode.contains('https') || _scanBarcode.contains('http')) {
        // return _launchURL(_scanBarcode!);

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Info(urlQRCode: _scanBarcode,)));
      } else {
        Fluttertoast.showToast(gravity: ToastGravity.BOTTOM, msg: 'Invalide URL');
      }
  }

  _launchURL(String urlQRCode) async {
    String url = urlQRCode;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
                  TextButton(onPressed: (){},child: Text('Generate QR')),
                  TextButton(onPressed: (){scanQR();},child: Text('Scan QR')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}