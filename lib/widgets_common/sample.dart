/* 
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firestore Array Chart Example'),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('your_collection').document('your_document_id').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            // Get the array from the document data
            List<dynamic> numbersArray = snapshot.data['numbers'] ?? [];

            // Calculate the sum of the numbers
            int sum = numbersArray.fold(0, (int currentSum, dynamic number) {
              return currentSum + (number as int);
            });

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Array of Numbers: $numbersArray'),
                  Text('Total Sum: $sum'),
                  Container(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        titlesData: FlTitlesData(leftTitles: SideTitles(showTitles: true)),
                        borderData: FlBorderData(show: true),
                        barGroups: numbersArray
                            .asMap()
                            .entries
                            .map((entry) => BarChartGroupData(
                                  x: entry.key,
                                  barRods: [
                                    BarChartRodData(y: entry.value.toDouble(), colors: [Colors.blue])
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
    );
  }
}
 */