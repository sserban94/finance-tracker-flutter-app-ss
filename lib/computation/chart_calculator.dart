import 'package:finances_tracker_app_ss_flutter/computation/statistics_calculator.dart';
import 'package:intl/intl.dart';

// TODO - Need clean code - DRY !!!
Map<String, double> computeCurrentDayIncome() {
  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  var today = intlDateFormatter.format(DateTime.now());
  Map<String, double> dailyIncomeMap = {today: 0};

  var transactions = getCurrentDayTransactions();
  for (var element in transactions) {
    if (element.type == 'Income') {
      dailyIncomeMap[today] = (dailyIncomeMap[today] ?? 0) + element.amount;
    }
  }
  return dailyIncomeMap;
}

Map<String, double> computeCurrentDayExpenses() {
  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  var today = intlDateFormatter.format(DateTime.now());
  Map<String, double> dailyExpensesMap = {today: 0};

  var transactions = getCurrentDayTransactions();
  for (var element in transactions) {
    if (element.type == 'Expense') {
      dailyExpensesMap[today] = (dailyExpensesMap[today] ?? 0) + element.amount;
    }
  }
  return dailyExpensesMap;
}

Map<String, double> computeDailyIncomeForLast7Days() {
  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  Map<String, double> dailyIncomeMap = {};
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

Map<String, double> computeDailyExpensesForLast7Days() {
  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  Map<String, double> dailyExpenseMap = {};
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

  Map<String, double> dailyIncomeMap = {};
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
      String date = intlDateFormatter.format(element.date);
      dailyIncomeMap[date] = (dailyIncomeMap[date] ?? 0) + element.amount;
    }
  }
  return dailyIncomeMap;
}

Map<String, double> computeDailyExpensesForCurrentMonth() {

  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  Map<String, double> dailyExpenseMap = {};
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
      String date = intlDateFormatter.format(element.date);
      dailyExpenseMap[date] = (dailyExpenseMap[date] ?? 0) + element.amount;
    }
  }
  return dailyExpenseMap;
}

Map<String, double> computeDailyIncomeForCurrentYear() {
  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  Map<String, double> dailyIncomeMap = {};

  var transactions = getCurrentYearTransactions();
  sortTransactionsByDate(transactions);
  for (var element in transactions) {
    if (element.type == 'Income') {
      // TODO - add date formatter to day only
      String date = intlDateFormatter.format(element.date);
      dailyIncomeMap[date] = (dailyIncomeMap[date] ?? 0) + element.amount;
    }
  }
  return dailyIncomeMap;
}

Map<String, double> computeDailyExpensesForCurrentYear() {
  final DateFormat intlDateFormatter = DateFormat('dd/MM');

  Map<String, double> dailyExpensesMap = {};

  var transactions = getCurrentYearTransactions();
  sortTransactionsByDate(transactions);
  for (var element in transactions) {
    if (element.type == 'Expense') {
      // TODO - add date formatter to day only
      String date = intlDateFormatter.format(element.date);
      dailyExpensesMap[date] = (dailyExpensesMap[date] ?? 0) + element.amount;
    }
  }
  return dailyExpensesMap;
}

