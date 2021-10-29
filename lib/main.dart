import 'package:flutter/material.dart';
import 'package:loan_calculator/screens/home_screen2.dart';
import 'package:loan_calculator/screens/landing_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color(0xff2b3e63),
      debugShowCheckedModeBanner: false,
      title: 'Loan Calculator',
      theme: ThemeData.light(),
      home: const HomeScreen2(),
    );
  }
}
