// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:atyrau_hub_hackaton/features/account/pages/account_page.dart';
import 'package:atyrau_hub_hackaton/features/app/pages/main_page.dart';
import 'package:atyrau_hub_hackaton/features/app/pages/scan_qr.dart';
import 'package:atyrau_hub_hackaton/features/info/auto.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late MotionTabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex:0,vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MotionTabBar(
          labels: const [
            'Главная','Scan','Аккаунт'
          ],
          initialSelectedTab: 'Главная',
          tabIconColor: Color(0xff4752b1).withOpacity(0.5),
          tabSelectedColor: Color(0xff4752b1),
          onTabItemSelected: (int value){
            print(value);
            setState(() {
              _tabController.index = value;
            });
          },
          icons: const [
            Icons.home,Icons.qr_code_scanner,Icons.account_box
          ],
          textStyle: TextStyle(color: Color(0xff4752b1)),
        ),
        body: MotionTabBarView(
          controller: _tabController,
          children: [
            MyHomePage(),
            ScanQr(),
            AccountPage(),
          ],
        ),
    );
  }
}
