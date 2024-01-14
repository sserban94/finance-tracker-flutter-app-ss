import 'package:finances_tracker_app_ss_flutter/computation/statistics_calculator.dart';
import 'package:finances_tracker_app_ss_flutter/data/top_expenses.dart';
import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
import 'package:finances_tracker_app_ss_flutter/storage/constant_storage.dart';
import 'package:finances_tracker_app_ss_flutter/widgets/my_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

// when the value inside is changed the listeners are notified
ValueNotifier valueNotifier = ValueNotifier(0);

// by using this leading underscore => private class (only available inside this file)
class _StatisticsState extends State<Statistics> {
  final DateFormat intlDateFormatter = DateFormat('EEEE');
  List timeInterval = ['Day', 'Week', 'Month', 'Year'];
  int selectedIndex = 0;

  // I will use these in this order
  // I will notify using the value notifier when the index is changed
  // I will use the value (which is the index) to call the function with that index
  // ex: Day has index 0 and computeTodayBalance() has index 0 as well
  List computationFunctions = [
    getCurrentDayTransactions(),
    getLast7DaysTransactions(),
    getCurrentMonthTransactions(),
    getCurrentYearTransactions()
  ];
  List<Transaction> transactions = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, dynamic value, child) {
          print("debug");
          transactions = computationFunctions[value];
          return buildCustomScrollView();
        },
      )),
    );
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Spending Analytics',
              style: TextStyle(
                fontSize: 20,
                color: statisticsTitleTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ... = spread operator -> spread a collection into another collection
                    ...List.generate(4, (index) {
                      // widget that detects gestures
                      return GestureDetector(
                        // when a user taps a gesture detector widget (which encapsulated a container in this case)
                        // the set state is called
                        // the setState is a critical function in Flutter
                        // it indicated the widget state has changed
                        // so the UI must be rebuilt with the new state
                        // the process is called diffing
                        // Flutter compares the new widget tree to the old one after setState
                        // the rendering is optimized behind the scenes
                        onTap: () {
                          // notifies state has changed
                          setState(() {
                            selectedIndex = index;
                            valueNotifier.value = index;
                          });
                        },
                        child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == index
                                  ? uiFocusColor
                                  : statisticsDefaultButtonBackgroundColor,
                            ),
                            alignment: Alignment.center,
                            child: Text(timeInterval[index],
                                style: TextStyle(
                                  color: selectedIndex == index
                                      ? statisticsFocusedButtonTextColor
                                      : statisticsDefaultButtonTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ))),
                      );
                    })
                  ]),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  width: 120,
                  height: 40,
                  // color: Colors.orange,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Expenses',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: statisticsTransactionTypeButtonTextColor)),
                        Icon(
                          Icons.arrow_downward,
                          color: statisticsTransactionTypeButtonArrowColor,
                        ),
                      ]),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: statisticsTransactionTypeButtonBorderColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                )
              ]),
            ),
            SizedBox(height: 20),
            // TODO - try to understand this
            Chart(index: selectedIndex),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Spending',
                    style: TextStyle(
                        color: statisticsTopSpendingTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.swap_vert, size: 25, color: statisticsSwapArrowsColor)
                ],
              ),
            )
          ],
        )),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                  'images/dropdown/transaction_names/${transactions[index].name.replaceAll(' ', '_').toLowerCase()}.png',
                  height: 40),
            ),
            title: Text(transactions[index].name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                )),
            subtitle: Text(
                '${intlDateFormatter.format(transactions[index].date)} ${transactions[index].date.day}.${transactions[index].date.month}.${transactions[index].date.year}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  // fontSize: 17,
                )),
            // trailing: Text('${transactions[index].amount % 1 == 0 ? transactions[index].amount.toInt() : transactions[index].amount}',
            //     style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //         fontSize: 19,
            //         color:
            //         transactions[index].type == 'Expense' ? Colors.red : Colors.green)),
          );
        }, childCount: transactions.length))
      ],
    );
  }
}
