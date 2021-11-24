import 'package:atyrau_hub_hackaton/features/info/auto.dart';
import 'package:atyrau_hub_hackaton/features/info/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScanQr extends StatefulWidget {
  const ScanQr({Key? key}) : super(key: key);

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff0000', 'Cancel', true, ScanMode.QR);
      debugPrint(barcodeScanRes);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    checkingValue(barcodeScanRes);
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkingValue(String _scanBarcode) {
    if (_scanBarcode.contains('https') || _scanBarcode.contains('http')) {
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Info(urlQRCode: _scanBarcode,)));
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AutoPage()));
    } else {
      Fluttertoast.showToast(gravity: ToastGravity.BOTTOM, msg: 'Invalide URL');
    }
  }

  @override
  initState() {
    super.initState();
    scanQR();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
