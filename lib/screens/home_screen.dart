import 'package:finances_tracker_app_ss_flutter/computation/balance_calculator.dart';
import 'package:finances_tracker_app_ss_flutter/computation/statistics_calculator.dart';

import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
import 'package:finances_tracker_app_ss_flutter/storage/constant_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

// Stateless widget does not require mutable state
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DateFormat intlDateFormatter = DateFormat('EEEE');
  // var transaction;
  final box = Hive.box<Transaction>('transaction');


  @override
  Widget build(BuildContext context) {
    // TODO - find a more efficient way of doing the same here
    var transactions = sortTransactionsByDate(box.values.toList()).reversed.toList();
    // visual scaffold for material design widgets
    return Scaffold(
        // SafeArea adds some padding to avoid intrusions by the OS
        body: SafeArea(
            child: ValueListenableBuilder(
      // whose value do I depend on for building
      // the listenable method notifies its listeners when something changes
      valueListenable: box.listenable(),
      builder: (context, value, child) {
        // 'child' is a widget that positions its children relative to its box
        //   child: _head(),
        // scroll view which uses slivers
        return CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: 340, child: _head()),
          ),
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transaction History",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: homeTransactionHistoryTextColor,
                  ),
                ),
                // TODO - add see all functionality -> full screen
                // Text(
                //   "See all",
                //   style: TextStyle(
                //     fontWeight: FontWeight.w600,
                //     fontSize: 15,
                //     color: homeSeeAllTextColor,
                //   ),
                // )
              ],
            ),
          )),
          // this sliver shows its box children in a list
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              // TODO - change var name
              // var transaction = box.values.toList()[index];
              var transaction = transactions[index];
              return getDismissibleTransaction(transaction, index);
            },
            // Important - always specify child count
            childCount: box.length,
          ))
        ]);
      },
    )));
  }

  Widget getDismissibleTransaction(Transaction transaction, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          transaction.delete();
        },
        child: getTransaction(index, transaction));
  }

  ListTile getTransaction(int index, Transaction transaction) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
            'images/dropdown/transaction_names/${transaction.name.replaceAll(' ', '_').toLowerCase()}.png',
            height: 40),
      ),
      title: Text(transaction.details,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          )),
      subtitle: Text(
          '${intlDateFormatter.format(transaction.date)} ${transaction.date.day}.${transaction.date.month}.${transaction.date.year}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            // fontSize: 17,
          )),
      trailing: Text('${transaction.amount % 1 == 0 ? transaction.amount.toInt() : transaction.amount}',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
              color:
                  transaction.type == 'Expense' ? homeExpenseAmountColor : homeIncomeAmountColor)),
    );
  }

  Widget _head() {
    double totalBalance = computeTotalBalance();
    double totalExpenses = computeTotalExpenses();
    double totalIncome = computeTotalIncome();
    // stack = stack layout widget
    return Stack(children: [
      // container is a widget which combines common painting, pos
      Column(
        children: [
          Container(
              width: double.infinity,
              height: 240,
              decoration: const BoxDecoration(
                color: homeHelloContainerColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  // topLeft: Radius.circular(20),
                  // topRight: Radius.circular(20)
                ),
              ),
              child: Stack(children: [
                // controls where a child of a stack is positioned
                Positioned(
                    top: 35,
                    left: 340,
                    // ClipRRect - widget what clips its child using a rounded rectangle
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                            height: 40,
                            width: 40,
                            color: homeNotificationBackgroundColor,
                            child: const Icon(
                              Icons.notification_add_outlined,
                              size: 30,
                              color: homeNotificationForegroundColor,
                            )))),

                const Padding(
                  padding: EdgeInsets.only(top: 35, left: 10),
                  // column = vertical array of children
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: homeHelloContainerTextColor),
                      ),
                      Text(
                        'Serban Scorteanu',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: homeHelloContainerTextColor),
                      ),
                    ],
                  ),
                )
              ])),
        ],
      ),
      Positioned(
        top: 160,
        left: 37,
        child: Container(
            height: 170,
            width: 320,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: homeTotalBalanceContainerShadowColor,
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  spreadRadius: 6,
                )
              ],
              color: homeTotalBalanceContainerBackgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Balance',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: homeTotalBalanceContainerTextColor),
                        ),
                        Icon(
                          Icons.more_horiz,
                          color: homeTotalBalanceContainerTextColor,
                        )
                      ]),
                ),
                SizedBox(height: 7),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(children: [
                    Text(
                      '${totalBalance % 1 == 0 ? totalBalance.toInt() : totalBalance} RON',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: homeTotalBalanceContainerTextColor,
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 25),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            // a circle which typically should represent an user
                            CircleAvatar(
                              radius: 13,
                              backgroundColor:
                              homeCircleColor,
                              child: Icon(Icons.arrow_downward,
                                  color: homeCircleArrowColor, size: 19),
                            ),
                            SizedBox(width: 7),
                            Text(
                              'Income',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: homeCircleTextColor,
                              ),
                            )
                          ]),
                          Row(children: [
                            // a circle which typically should represent an user
                            CircleAvatar(
                              radius: 13,
                              backgroundColor:
                                  homeCircleColor,
                              child: Icon(Icons.arrow_upward,
                                  color: homeCircleArrowColor, size: 19),
                            ),
                            SizedBox(width: 7),
                            Text(
                              'Expenses',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: homeCircleTextColor,
                              ),
                            )
                          ]),
                        ])),
                SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${totalIncome % 1 == 0 ? totalIncome.toInt() : totalIncome} RON',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: homeTotalIncomeTextColor,
                          )),
                      Text('${totalExpenses % 1 == 0 ? totalExpenses.toInt() : totalExpenses} RON',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: homeTotalExpensesTextColor,
                          )),
                    ],
                  ),
                )
              ],
            )),
      )
    ]);
  }
}
