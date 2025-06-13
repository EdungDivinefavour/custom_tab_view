import 'package:flutter/material.dart';
import 'package:customtabview/custom_tab_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomTabView(
          itemCount: 3,
          tabBuilder: (context, index) => Tab(text: 'Tab $index'),
          pageBuilder: (context, index) => Center(child: Text('Page $index')),
          initPosition: 0,
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
        ),
      ),
    );
  }
}
