// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class AutoPage extends StatefulWidget {
  const AutoPage({Key? key}) : super(key: key);

  @override
  _AutoPageState createState() => _AutoPageState();
}

class _AutoPageState extends State<AutoPage> {

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
          title: const Text('Qr scanner'),
          centerTitle: true,
          backgroundColor: Color(0xff4752b1),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Forms(context: context,name: 'Заявитель',data: 'Валерий Большаков'),
              Forms(context: context,name: 'Государственный номер',data: '543RTY'),
              Forms(context: context,name: 'Марка транспорта',data: 'AVC MARK'),
              Forms(context: context,name: 'Компания заявитель',data: 'My company'),
              Forms(context: context,name: 'Зарегистрированный владелец',data: 'Арман Аманжолов'),
              Forms(context: context,name: 'Ранее регистрирован',data: 'Нет'),
              Forms(context: context,name: 'Дата подачи',data: '11/22/2021'),
              Forms(context: context,name: 'Дата въезда',data: '11/24/2021'),
              Forms(context: context,name: 'Категория транспорта',data: 'Социальный автомобиль'),
              Forms(context: context,name: 'Модель транспорта',data: 'Модель 1'),
              Forms(context: context,name: 'Год выпуска',data: '2000'),
              Forms(context: context,name: 'Страна изготовитель',data: 'Россия'),
              Forms(context: context,name: 'Сборочный завод',data: 'Водный завод'),
              Forms(context: context,name: 'Сторона движения',data: 'Left'),
            ]
          ),
        ),
      ),
    );
  }

}

class Forms extends StatelessWidget {
  final String name;
  final String data;
  final BuildContext context;

  const Forms({Key? key, required this.name, required this.data,required this.context}) : super(key: key);

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(color: Colors.black, fontSize: 16.0,), textAlign: TextAlign.start,),
        SizedBox(height: 8.0,),
        Container(height: 30.0,width: MediaQuery.of(context).size.width * 0.9,decoration: BoxDecoration(color: Color(0xff4752b1), borderRadius: BorderRadius.circular(6.0)), child: Container(padding: EdgeInsets.only(left: 8.0,top: 4.0),child: Text(data, style: TextStyle(color: Colors.white, fontSize: 18.0,),))),
        SizedBox(height: 10.0,),
      ],
    );
  }
}
