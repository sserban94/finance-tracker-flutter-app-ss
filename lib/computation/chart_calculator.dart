import 'package:finances_tracker_app_ss_flutter/computation/statistics_calculator.dart';
import 'package:intl/intl.dart';

// TODO - Need clean code
Map<String, double> computeDailyIncomeForLast7Days() {
  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  Map<String, double> dailyIncomeMap = {
  };
  DateTime now = DateTime.now();
  for (int i = 7; i >= 0; i--) {
    DateTime newDate = DateTime(now.year, now.month, now.day - i);
    String newFormattedDate = intlDateFormatter.format(newDate);
    dailyIncomeMap[newFormattedDate] = 0;
  }

  var transactions = getLast7DaysTransactions();
  for (var element in transactions) {
    if (element.type == 'Income') {
      String day = intlDateFormatter.format(element.date);
      dailyIncomeMap[day] = (dailyIncomeMap[day] ?? 0) + element.amount;
    }
  }
  return dailyIncomeMap;
}

Map<String, double> computeDailyExpenseForLast7Days() {
  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  Map<String, double> dailyExpenseMap = {
  };
  DateTime now = DateTime.now();
  for (int i = 7; i >= 0; i--) {
    DateTime newDate = DateTime(now.year, now.month, now.day - i);
    String newFormattedDate = intlDateFormatter.format(newDate);
    dailyExpenseMap[newFormattedDate] = 0;
  }
  var transactions = getLast7DaysTransactions();

  for (var element in transactions) {
    if (element.type == 'Expense') {
      String day = intlDateFormatter.format(element.date);
      dailyExpenseMap[day] = (dailyExpenseMap[day] ?? 0) + element.amount;
    }
  }
  return dailyExpenseMap;
}

Map<String, double> computeDailyIncomeForCurrentMonth() {
  // final DateFormat intlDateFormatter = DateFormat('dd/MM');
  //
  // Map<String, double> dailyIncomeMap = {};
  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  Map<String, double> dailyIncomeMap = {
  };
  DateTime now = DateTime.now();
  DateTime firstDayCurrentMonth = DateTime(now.year, now.month, 1);


  for (int i = now.day; i >= firstDayCurrentMonth.day; i--) {
    DateTime newDate = DateTime(now.year, now.month, now.day - i);
    String newFormattedDate = intlDateFormatter.format(newDate);
    dailyIncomeMap[newFormattedDate] = 0;
  }

  var transactions = getCurrentMonthTransactions();
  for (var element in transactions) {
    if (element.type == 'Income') {
      // TODO - add date formatter to day only
      String date = intlDateFormatter.format(element.date);
      dailyIncomeMap[date] = (dailyIncomeMap[date] ?? 0) + element.amount;
    }
  }
  return dailyIncomeMap;
}

Map<String, double> computeDailyExpenseForCurrentMonth() {
  // final DateFormat intlDateFormatter = DateFormat('dd/MM');
  //
  // Map<String, double> dailyExpenseMap = {};

  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  Map<String, double> dailyExpenseMap = {
  };
  DateTime now = DateTime.now();
  DateTime firstDayCurrentMonth = DateTime(now.year, now.month, 1);


  for (int i = now.day; i >= firstDayCurrentMonth.day; i--) {
    DateTime newDate = DateTime(now.year, now.month, now.day - i);
    String newFormattedDate = intlDateFormatter.format(newDate);
    dailyExpenseMap[newFormattedDate] = 0;
  }

  var transactions = getCurrentMonthTransactions();
  for (var element in transactions) {
    if (element.type == 'Expense') {
      // TODO - add date formatter to day only
      // String date = intlDateFormatter.format(element.date);
      String date = intlDateFormatter.format(element.date);
      dailyExpenseMap[date] = (dailyExpenseMap[date] ?? 0) + element.amount;
    }
  }
  return dailyExpenseMap;
}