// import 'package:finances_tracker_app_ss_flutter/computation/statistics_calculator.dart';
// import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
//
// class Chart extends StatefulWidget {
//   int index;
//
//   // first key is the name of the parameters in the super class, the second the arg
//   // keys are used in flutter to uniquely identify widgets
//   Chart({Key? key, required this.index}) : super(key: key);
//
//   // this returns an instance of _ChartState - linking the widget with its state
//   @override
//   State<Chart> createState() => _ChartState();
// }
//
// // chart state is the state of the chart widget
// // by extending State<Chart> => it holds the mutable state for the Chart widget
// class _ChartState extends State<Chart> {
//   List<Transaction>? transactions;
//   bool b = true;
//   bool j = true;
//
//   // whenever the state changes -> build is called in order to redraw the UI
//   // BuildContext param = holds the context of this widget -> in the widget tree
//   @override
//   Widget build(BuildContext context) {
//     switch (widget.index) {
//       case 0:
//         transactions = getCurrentDayTransactions();
//         b = true;
//         j = true;
//         break;
//       case 1:
//         transactions = getLast7DaysTransactions();
//         b = false;
//         j = true;
//         break;
//       case 2:
//         transactions = getCurrentMonthTransactions();
//         b = false;
//         j = true;
//         break;
//       case 3:
//         transactions = getCurrentYearTransactions();
//         // b = false;
//         j = true;
//         break;
//       default:
//         break;
//     }
//
//     return Container(
//       width: double.infinity,
//       height: 300,
//       child: SfCartesianChart(
//         primaryXAxis: CategoryAxis(),
//         series: <SplineSeries<SalesData, String>>[
//           SplineSeries<SalesData, String>(
//             color: uiFocusColor,
//             width: 3,
//             dataSource: <SalesData>[
//               ...List.generate(time(transactions!, b).length, (index) {
//                 // return SalesData(
//                 //     j
//                 //         ? b
//                 //             ? transactions![index].date.hour.toString()
//                 //             : transactions![index].date.day.toString()
//                 //         : transactions![index].date.month.toString(),
//                 //     b
//                 //         ? index > 0
//                 //             ? time(transactions!, true)[index] +
//                 //                 time(transactions!, true)[index - 1]
//                 //             : time(transactions!, true)[index]
//                 //         : index > 0
//                 //             ? time(transactions!, false)[index] +
//                 //                 time(transactions!, false)[index - 1]
//                 //             : time(transactions!, false)[index]);
//                 String xAxisValue;
//                 double yAxisValue;
//                 // Set x axis value
//                 if (j) {
//                   if (b) {
//                     xAxisValue = transactions![index].date.hour.toString();
//                   } else {
//                     xAxisValue = transactions![index].date.day.toString();
//                   }
//                 } else {
//                   xAxisValue = transactions![index].date.month.toString();
//                 }
//
//                 // Set y axis value
//                 if (index > 0) {
//                   double currentValue = time(transactions!, b)[index];
//                   double previousValue = time(transactions!, b)[index - 1];
//                   yAxisValue = currentValue + previousValue;
//                 } else {
//                   yAxisValue = time(transactions!, b)[index];
//                 }
//                 return SalesData(xAxisValue, yAxisValue);
//
//               })
//             ],
//             xValueMapper: (SalesData sales, _) => sales.year,
//             yValueMapper: (SalesData sales, _) => sales.sales,
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class SalesData {
//   SalesData(this.year, this.sales);
//
//   final String year;
//   final double sales;
// }
