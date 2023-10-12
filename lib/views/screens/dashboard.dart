import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime currDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('sales')
                  .doc('daily_sales')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                String thisDay =
                    '${currDay.day}_${currDay.month}_${currDay.year}';

                // Get the array from the document data
                List<dynamic> numbersArray = snapshot.data![thisDay] ?? [];

                // Calculate the sum of the numbers
                int sum =
                    numbersArray.fold(0, (int currentSum, dynamic number) {
                  return currentSum + (number as int);
                });

                var totalAmount = NumberFormat.simpleCurrency(
                  locale: 'fil_PH',
                  decimalDigits: 2,
                ).format(
                  sum,
                );

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Total Sales for $thisDay: $totalAmount',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        child: BarChart(
                          BarChartData(
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: true),
                            barGroups: numbersArray
                                .asMap()
                                .entries
                                .map((entry) => BarChartGroupData(
                                      x: entry.key,
                                      barRods: [
                                        BarChartRodData(
                                            toY: entry.value.toDouble(),
                                            color: Colors.blue)
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
