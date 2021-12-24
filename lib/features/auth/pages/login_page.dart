// ignore_for_file: prefer_const_constructors

import 'package:atyrau_hub_hackaton/features/app/pages/app_page.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;
  bool isInitialized = false;

  @override
  void initState() {
    FlutterMobileVision.start().then((value){
      isInitialized = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Войти'), backgroundColor: Color(0xff4752b1),),
      body: ModalProgressHUD(
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        inAsyncCall: _isLoggedIn,
        child: Column(
          children: [
            Container(
              height: 150.0,
              width: 190.0,
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Image.asset('assets/images/icon.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Логин',
                    hintText: 'abc@gmail.com',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Пароль',
                    hintText: ''
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Должность',
                    hintText: ''
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff4752b1)),
              ),
              onPressed: (){

              },
              child: Text(
                'Забыли пароль?',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff4752b1))),onPressed: (){}, child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color(0xff4752b1), borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff4752b1)),
                ),
                onPressed: () async {
                  setState(() {
                    _isLoggedIn = true;
                  });
                  await Future.delayed(const Duration(seconds: 3));
                  Navigator.push(
                        context, MaterialPageRoute(builder: (_) => App()));
                },
                child: Text(
                  'Войти',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
