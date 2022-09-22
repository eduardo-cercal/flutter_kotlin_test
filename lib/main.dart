import 'package:flutter/material.dart';

import 'Screen/home/home_screen.dart';

void main()=>runApp(const FlutterKotlinApp());

class FlutterKotlinApp extends StatelessWidget {
  const FlutterKotlinApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
