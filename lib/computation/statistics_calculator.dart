import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
import 'package:hive/hive.dart';

var box = Hive.box<Transaction>('transaction');

double total = 0;

List<Transaction> getCurrentDayTransactions() {
  List<Transaction> transactions = [];
  DateTime now = DateTime.now();
  var boxList = box.values.toList();
  boxList.forEach((element) {
    if (element.date.day == now.day) {
      transactions.add(element);
    }
  });
  return transactions;
}


List<Transaction> getLast7DaysTransactions() {
  List<Transaction> transactions = [];
  DateTime now = DateTime.now();
  var boxList = box.values.toList();
  boxList.forEach((element) {
    if (element.date.day >= now.day - 7 &&
        element.date.day <= now.day) {
      transactions.add(element);
    }
  });
  return transactions;
}

List<Transaction> getCurrentWeekTransactions() {
  List<Transaction> transactions = [];
  DateTime now = DateTime.now();
  var boxList = box.values.toList();
  boxList.forEach((element) {
    if (element.date.day >= now.day - 7 &&
        element.date.day <= now.day &&
        element.date.weekday <= now.weekday
    )   {
      transactions.add(element);
    }
  });
  return transactions;
}

List<Transaction> getLast30DaysTransactions() {
  List<Transaction> transactions = [];
  DateTime now = DateTime.now();
  var boxList = box.values.toList();
  boxList.forEach((element) {
    if (now.day - 30 <= element.date.day && element.date.day <= now.day) {
      transactions.add(element);
    }
  });
  return transactions;
}

List<Transaction> getCurrentMonthTransactions() {
  List<Transaction> transactions = [];
  DateTime now = DateTime.now();
  var boxList = box.values.toList();
  boxList.forEach((element) {
    if (element.date.month == now.month) {
      transactions.add(element);
    }
  });
  return transactions;
}

List<Transaction> getLast365DaysTransactions() {
  List<Transaction> transactions = [];
  DateTime now = DateTime.now();
  var boxList = box.values.toList();
  boxList.forEach((element) {
    if (now.day - 365 <= element.date.day && element.date.day <= now.day) {
      transactions.add(element);
    }
  });
  return transactions;
}

List<Transaction> getCurrentYearTransactions() {
  List<Transaction> transactions = [];
  DateTime now = DateTime.now();
  var boxList = box.values.toList();
  boxList.forEach((element) {
    if (element.date.year == now.year) {
      transactions.add(element);
    }
  });
  return transactions;
}

List<Transaction> filterTransactionsGetExpenses(List<Transaction> transactions) {
  // TODO - need to change this
  return transactions.where((x) => x.type == 'Expense').toList();
}

List<Transaction> sortTransactionsByAmount(List<Transaction> transactions) {
  transactions.sort((a, b) => b.amount.compareTo(a.amount));
  return transactions;
}

List<Transaction> sortTransactionsByDate(List<Transaction> transactions) {
  transactions.sort((a, b) => a.date.compareTo(b.date));
  return transactions;
}







