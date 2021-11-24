// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose (){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Личный кабинет'),
          centerTitle: true,
          backgroundColor: Color(0xff4752b1),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),), child: Image.asset('assets/images/customer.png', height: 140.0, width: 140.0,)),
                      Expanded(
                        child: Column(
                          children: const [
                            Text('Сергей', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,),),
                            Text('Владимирович',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,),),
                            Text('Служба Безопасности',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.only(right: 24.0, left: 24.0, top: 8.0, bottom: 8.0,),
                      // height: 23.0,
                      decoration: BoxDecoration(
                        color: Color(0xff4752b1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.edit,color: Colors.white,),
                          SizedBox(width: 10.0,),
                          Text('Изменить профиль', style: TextStyle(color: Colors.white,),),
                        ],
                      ),
                    ),

                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.9, child: ElevatedButton( style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff4752b1))),onPressed: (){Navigator.of(context).pop();}, child: Text('Выйти',))),
            ],
          ),
        ),
      ),
    );
  }
}