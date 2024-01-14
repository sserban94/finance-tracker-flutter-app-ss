import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

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

// int total_chart(List<Transaction> transactions) {
//   List a = [0, 0];
//
//   for (var i = 0; i < transactions.length; i++) {
//     a.add(transactions[i].IN == 'Income'
//         ? int.parse(transactions[i].amount)
//         : int.parse(transactions[i].amount) * -1);
//   }
//   totals = a.reduce((value, element) => value + element);
//   return totals;
// }
//
// List time(List<Add_data> history2, bool hour) {
//   List<Add_data> a = [];
//   List total = [];
//   int counter = 0;
//   for (var c = 0; c < history2.length; c++) {
//     for (var i = c; i < history2.length; i++) {
//       if (hour) {
//         if (history2[i].datetime.hour == history2[c].datetime.hour) {
//           a.add(history2[i]);
//           counter = i;
//         }
//       } else {
//         if (history2[i].datetime.day == history2[c].datetime.day) {
//           a.add(history2[i]);
//           counter = i;
//         }
//       }
//     }
//     total.add(total_chart(a));
//     a.clear();
//     c = counter;
//   }
//   print(total);
//   return total;
// }





