import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';

class DetailScreen extends StatelessWidget {
  final double? amount;
  final double? rate;
  final double? month;
  //final double? year;
  final double? monthlyInterest;
  final double? totalInterest;
  const DetailScreen({
    Key? key,
    this.amount,
    this.rate,
    this.month = 0,
    this.monthlyInterest,
    this.totalInterest,
    //this.year
  }) : super(key: key);
  final sizeBox = const SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.keyboard_backspace)),
                  const Spacer(),
                  const Text(
                    'Finance Calculator',
                    style: bodyTextStyle,
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Material(
                elevation: 8,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18)),
                  ),
                  child: Column(
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
                      const Center(
                        child: Text('Loan Summary', style: bodyTextStyle),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Card(
                          color: const Color(0xfff2f2f2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                detailText('Loan amount', formatter(amount)),
                                sizeBox,
                                detailText(
                                    'Interest %', rate!.toStringAsFixed(1)),
                                sizeBox,
                                detailText('No. of Payments',
                                    month!.toStringAsFixed(0)),
                                sizeBox,
                                detailText('Monthly payment',
                                    monthlyInterest!.toStringAsFixed(1)),
                                sizeBox,
                                detailText(
                                    'Total interest', formatter(totalInterest)),
                                sizeBox,
                                detailText('Total to be repaid', '542'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Card(
                          color: const Color(0xfff2f2f2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                pieChartIndicator(
                                    'Loan', const Color(0xfffe8040)),
                                pieChartIndicator(
                                  'Interest',
                                  const Color(0xff2b3e63),
                                ),
                                SizedBox(
                                    height: 180,
                                    width: 180,
                                    child: PieChart(
                                        PieChartData(sections: getSection()))),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> getSection() => [
        PieChartSectionData(
          value: totalInterest,
          title: '',
          color: const Color(0xff2b3e63),
        ),
        PieChartSectionData(
            title: '', value: amount, color: const Color(0xfffe8040)),
      ];
}

Widget generateLines() => Row(
      children: List.generate(
          2,
          (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 2,
                  width: 15,
                  color: Colors.grey,
                ),
              )),
    );

String formatter(value) => NumberFormat('#,###,###,###').format(value);

Widget detailText(String text, String value) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: detailTextStyle),
          generateLines(),
          Text(
            value,
            style: detailTextStyle.copyWith(color: const Color(0xfffe8040)),
          )
        ],
      ),
    );

Widget pieChartIndicator(String title, Color color) => Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            child: Center(
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(50)),
          ),
          const SizedBox(width: 6, height: 6),
          Text(title, style: detailTextStyle),
        ],
      ),
    );
