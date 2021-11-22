import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Info extends StatelessWidget {
  String? urlQRCode;
  Info({Key? key, this.urlQRCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qr code',),backgroundColor: const Color(0xff4752b1),),
      body: SafeArea(
        child: WebView(
          initialUrl: urlQRCode!,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
