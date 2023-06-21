import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartExample extends StatelessWidget {
  final List<SalesData> chartData = [
    SalesData(2010, 35),
    SalesData(2011, 28),
    SalesData(2012, 34),
    SalesData(2013, 32),
    SalesData(2014, 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chart Example'),
      ),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <ChartSeries>[
            LineSeries<SalesData, int>(
              dataSource: chartData,
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  final int year;
  final double sales;

  SalesData(this.year, this.sales);
}
