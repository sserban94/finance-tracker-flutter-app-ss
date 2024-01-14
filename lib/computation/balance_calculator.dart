import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
import 'package:hive/hive.dart';

var box = Hive.box<Transaction>('transaction');

double computeTotalBalance() {
  double totalBalance = 0;
  box.values.toList().forEach((element) {
    if (element.type == 'Income') {
      totalBalance += element.amount;
    } else {
      totalBalance -= element.amount;
    }
  });
  return totalBalance;
}

double computeTotalExpenses() {
  double totalExpenses = 0;
  // var expensesList = box.values
  //     .toList()
  //     .where((element) => element.type == 'Expense')
  //     .map((element) => element.amount);
  // totalExpenses = expensesList.reduce((value, element) => value + element);
  box.values.toList().forEach((element) {
    if (element.type == 'Expense') {
      totalExpenses += element.amount;
    }
  });
  return totalExpenses;
}

double computeTotalIncome() {
  double totalIncome = 0;
  // var incomeList = box.values
  //     .toList()
  //     .where((element) => element.type == 'Income')
  //     .map((element) => element.amount);
  // totalIncome = incomeList.reduce((value, element) => value + element);
  box.values.toList().forEach((element) {
    if (element.type == 'Income') {
      totalIncome += element.amount;
    }
  });
  return totalIncome;
}
