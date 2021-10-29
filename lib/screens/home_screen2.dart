import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loan_calculator/screens/detail_screen.dart';
import 'package:loan_calculator/screens/home_screen.dart';
import 'package:loan_calculator/widget/custom_textfield.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final sizeBox = const SizedBox(height: 12);
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final rateController = TextEditingController();
  final timeController = TextEditingController();
  final timeController2 = TextEditingController();
  final rateFocusNode = FocusNode();
  final timeFocusNode = FocusNode();
  final timeFocusNode2 = FocusNode();
  int selectedIndex = 0;
  double get amount => double.parse(amountController.text);
  double get rate => double.parse(rateController.text) / 100;
  double get year => double.parse(timeController.text);
  double get month => double.parse(timeController2.text);
  String get formatter => NumberFormat('#,###,###,###').format(amount);
  double monthlyInterest() =>
      (rate / month) +
      (rate / month) / ((1 + rate / month) * math.exp(month - 1)) * amount;

  double get totalInterest => amount * rate * year / 100;
  double get repaymentAmount => amount * (1 + (rate / 100 * year));
  void reset() {
    setState(() {
      amountController.clear();
      rateController.clear();
      timeController.clear();
      timeController2.clear();
    });
  }

  Widget selectedIndexButton(VoidCallback onTap, Color color, String text) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 800),
                height: 45,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(10)),
                child: Text(text,
                    style: headingTextStyle.copyWith(color: Colors.white))),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(flex: 2),
                  const Text('Loan Calculator', style: bodyTextStyle),
                  const Spacer(),
                  IconButton(
                      onPressed: () => print(monthlyInterest()),
                      icon: const Icon(Icons.refresh))
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Material(
                elevation: 6,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 60,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            )),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     selectedIndexButton(
                            //         () => setState(() => selectedIndex = 0),
                            //         selectedIndex == 0
                            //             ? const Color(0xff06193f)
                            //             : Colors.grey,
                            //         'Yearly'),
                            //     selectedIndexButton(
                            //         () => setState(() => selectedIndex = 1),
                            //         selectedIndex == 1
                            //             ? const Color(0xff06193f)
                            //             : Colors.grey,
                            //         'Monthly'),
                            //   ],
                            // ),
                            const SizedBox(height: 25),
                            const Text('Loan Amount', style: headingTextStyle),
                            CustomTextfield(
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(rateFocusNode),
                                validator: (value) =>
                                    value!.isEmpty ? 'Enter a value' : null,
                                controller: amountController,
                                hintText: '10000'),
                            sizeBox,
                            const Text('Annual interest rate %',
                                style: headingTextStyle),
                            CustomTextfield(
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(timeFocusNode),
                              textInputAction: TextInputAction.next,
                              focusNode: rateFocusNode,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter a value' : null,
                              hintText: '5',
                              controller: rateController,
                            ),
                            sizeBox,
                            const Text('Years?', style: headingTextStyle),
                            CustomTextfield(
                              focusNode: timeFocusNode,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(timeFocusNode2),
                              hintText: '2',
                              controller: timeController,
                            ),
                            sizeBox,

                            const Text('Months?', style: headingTextStyle),
                            CustomTextfield(
                              focusNode: timeFocusNode2,
                              hintText: '3',
                              controller: timeController2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 55,
              child: MaterialButton(
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                color: const Color(0xff06193f),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => DetailScreen(
                            amount: amount,
                            totalInterest: totalInterest,
                            rate: rate,
                            month: 0,
                            monthlyInterest: monthlyInterest())));
                  }
                },
                child: Text(
                  'Calculate',
                  style: headingTextStyle.copyWith(
                      color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
