import 'package:flutter/material.dart';
import 'package:loan_calculator/screens/home_screen.dart';
import 'package:loan_calculator/screens/home_screen2.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const HomeScreen()));
                      },
                      child: const Text(
                        'Loan Calculator 1',
                        style: headingTextStyle,
                      )),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const HomeScreen2()));
                      },
                      child: const Text(
                        'Loan Calculator 2',
                        style: headingTextStyle,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
