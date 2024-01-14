import 'dart:math';

import 'package:finances_tracker_app_ss_flutter/computation/balance_calculator.dart';
import 'package:finances_tracker_app_ss_flutter/computation/chart_calculator.dart';
import 'package:finances_tracker_app_ss_flutter/computation/statistics_calculator.dart';
import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
import 'package:finances_tracker_app_ss_flutter/storage/constant_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  int index;

  // first key is the name of the parameters in the super class, the second the arg
  // keys are used in flutter to uniquely identify widgets
  Chart({Key? key, required this.index}) : super(key: key);

  // this returns an instance of _ChartState - linking the widget with its state
  @override
  State<Chart> createState() => _ChartState();
}

// chart state is the state of the chart widget
// by extending State<Chart> => it holds the mutable state for the Chart widget
class _ChartState extends State<Chart> {
  late Map<String, double> incomeMap;
  late Map<String, double> expenseMap;

  final bool isDataLabelVisible = true,
      isMarkerVisible = true,
      isTooltipVisible = true;
  double? lineWidth, markerWidth, markerHeight;

  // whenever the state changes -> build is called in order to redraw the UI
  // BuildContext param = holds the context of this widget -> in the widget tree
  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      // TODO - change these
      case 0:
        incomeMap = computeDailyIncomeForLast7Days();
        expenseMap = computeDailyExpenseForLast7Days();
        break;
      case 1:
        incomeMap = computeDailyIncomeForLast7Days();
        expenseMap = computeDailyExpenseForLast7Days();
        print("");
        break;
      case 2:
        incomeMap = computeDailyIncomeForCurrentMonth();
        expenseMap = computeDailyExpenseForCurrentMonth();
        print("");
        break;
      case 3:
        incomeMap = computeDailyIncomeForCurrentMonth();
        expenseMap = computeDailyExpenseForCurrentMonth();
        break;
      default:
        break;
    }

    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            enableTooltip: true,
            // color: uiFocusColor,
            color: chartExpenseLineColor,
            width: 3,
            dataSource: <SalesData>[
              ...expenseMap.entries.map(
          (entry) {
            return SalesData(entry.key, entry.value);
              })
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,

          markerSettings: MarkerSettings(
          isVisible: isMarkerVisible,
          height: markerWidth ?? 4,
      width: markerHeight ?? 4,
          shape: DataMarkerType.circle,
          borderWidth: 3,
          borderColor: chartBorderColor),
        dataLabelSettings: DataLabelSettings(
            isVisible: isDataLabelVisible,
            labelAlignment: ChartDataLabelAlignment.auto)
        )

        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
