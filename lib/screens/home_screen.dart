import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String formatter(n) => NumberFormat.currency().format(n);
  double borrowedAmount = 1000;
  double maximumAmount = 10000;
  double repaymentPeriod = 5;
  double interest = 0;
  bool isDone = false;
  double get monthlyPayment => borrowedAmount >= 4000 ? 200 : 100;

  String totalLoanCost() {
    var sI = borrowedAmount * interest * repaymentPeriod / 100;
    return formatter(sI);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('LOAN CALCULATOR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Borrowed Amount', style: headingTextStyle),
                    Text(
                      formatter(borrowedAmount),
                      style: bodyTextStyle,
                    ),
                    Slider(
                        label: borrowedAmount.round().toString(),
                        divisions: 20,
                        min: 1000,
                        max: 10000,
                        value: borrowedAmount,
                        onChanged: (v) {
                          setState(() => borrowedAmount = v);
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('\$1,000', style: slideTextStyle),
                          Text('\$10,000', style: slideTextStyle),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text('Repayment Period', style: headingTextStyle),
                    Text('${repaymentPeriod.toStringAsFixed(0)} Months',
                        style: bodyTextStyle),
                    Slider(
                        min: 5,
                        max: 36,
                        divisions: 26,
                        value: repaymentPeriod,
                        label: repaymentPeriod.round().toString(),
                        onChanged: (v) => setState(() => repaymentPeriod = v)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('5 months', style: slideTextStyle),
                          Text('36 months', style: slideTextStyle),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text('Interest Rate', style: headingTextStyle),
                    Text('%${interest.toStringAsFixed(0)}',
                        style: bodyTextStyle),
                    Slider(
                        min: 0,
                        max: 25,
                        divisions: 25,
                        value: interest,
                        label: interest.round().toString(),
                        onChanged: (v) => setState(() => interest = v)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'monthly cost for ${repaymentPeriod.toStringAsFixed(0)} months',
                          style: slideTextStyle),
                      Text(formatter(monthlyPayment), style: bodyTextStyle),
                      const SizedBox(height: 20),
                      AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: !isDone
                              ? const SizedBox.shrink()
                              : Text(
                                  'You are borrowing ${formatter(borrowedAmount)} over ${repaymentPeriod.toStringAsFixed(0)} months at ${interest.toStringAsFixed(0)} rate with a total loan cost of ${totalLoanCost()}. No added fees.',
                                  style: slideTextStyle))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        child: OutlinedButton(
          onPressed: () => setState(() => isDone = true),
          child: const Text('DONE', style: headingTextStyle),
        ),
      ),
    ));
  }
}

const slideTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

const detailTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w500);

const bodyTextStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

const headingTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w800);
