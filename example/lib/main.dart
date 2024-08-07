import 'package:flutter/material.dart';
import 'package:lit_vertical_tabbar/lit_element_model.dart';
import 'package:lit_vertical_tabbar/lit_vertical_tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final children = [
      LitElementModel(
        tabName: 'My Beautiful Dark Twisted Fantasy',
        child: Image.asset('assets/mbdtf.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
      LitElementModel(
        tabName: 'Graduation',
        child: Image.asset('assets/graduation.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
      LitElementModel(
        tabName: 'The College Dropout',
        child: Image.asset('assets/colledge.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
      LitElementModel(
        tabName: 'Vultures',
        child: Image.asset('assets/vultures.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
      LitElementModel(
        tabName: '808s & Heardbreak',
        child: Image.asset('assets/808.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
      LitElementModel(
        tabName: 'Yeezus',
        child: Image.asset('assets/yeezus.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
      LitElementModel(
        tabName: 'The Life Of Pablo',
        child: Image.asset('assets/father.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
      LitElementModel(
        tabName: 'JESUS IS KING',
        child: Image.asset('assets/jesus.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
      LitElementModel(
        tabName: 'YE',
        child: Image.asset('assets/ye.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
      LitElementModel(
        tabName: 'Donda',
        child: Image.asset('assets/donda.png', width: 360, height: 360, fit: BoxFit.contain),
      ),
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
          divider: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              Text('kanye da 🐐 no 🧢', style: TextStyle(color: Colors.white)),
              Divider(),
            ],
          ),
          children: children,
        ),
      ),
    );
  }
}
