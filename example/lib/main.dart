import 'package:flutter/material.dart';
import 'package:lit_vertical_tabbar/lit_vertical_tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final tabsString = [
      'My Beautiful Dark Twisted Fantasy',
      'Graduation',
      'The College Dropout',
      'Vultures',
      '808s & Heardbreak',
      'Yeezus',
      'The Life Of Pablo',
      'JESUS IS KING',
      'YE',
      'Donda',
    ];

    final assetPaths = [
      'assets/mbdtf.png',
      'assets/graduation.png',
      'assets/colledge.png',
      'assets/vultures.png',
      'assets/808.png',
      'assets/yeezus.png',
      'assets/father.png',
      'assets/jesus.png',
      'assets/ye.png',
      'assets/donda.png',
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Kanye West - Top 10 Albums',
            style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w700),
          ),
        ),
        body: LitVerticalTabBar(
          backgroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 24),
          moveTabToLastIndexOnScrollEnd: true,
          tabs: tabsString.map((e) => Tab(text: e)).toList(),
          divider: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              Text('kanye da 🐐 no 🧢', style: TextStyle(color: Colors.white)),
              Divider(),
            ],
          ),
          children: assetPaths.map((e) => Image.asset(e, width: 360.0, height: 360.0, fit: BoxFit.contain)).toList(),
        ),
      ),
    );
  }
}
