import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
import 'package:finances_tracker_app_ss_flutter/storage/constant_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

// by using this leading underscore => private class (only available inside this file)
class _NewTransactionState extends State<NewTransaction> {
  // will open this box in main.dart
  final hiveBox = Hive.box<Transaction>('transaction');

  String? selectedTransactionName;
  String? selectedTransactionType;
  DateTime selectedDateTime = DateTime.now();

  // FN = object used by StatefulWidget to obtain keyboard focus and handle keyboard events
  FocusNode transactionDetailsFocusNode = FocusNode();
  final TextEditingController transactionDetailsTEC = TextEditingController();

  FocusNode transactionAmountFocusNode = FocusNode();
  final TextEditingController transactionAmountTEC = TextEditingController();

  final List<String> _transactionNameDropdownValues = [
    'Food',
    'Bank Transfer',
    'Transportation',
    'Education'
  ];

  final List<String> _transactionTypeDropdownValues = [
    'Expense',
    'Income',
  ];

  // called when this in inserted in tree. called once for each state
  @override
  void initState() {
    super.initState();
    transactionDetailsFocusNode.addListener(() {
      setState(() {});
    });
    transactionAmountFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: newTransactionBottomContainerColor,
      // again - SafeArea avoids OS interfaces
      body: SafeArea(
          // Stack = Stack Layout Widget
          child: Stack(alignment: AlignmentDirectional.center, children: [
        buildBackgroundContainer(context),
        Positioned(top: 120, child: buildMainContainer())
      ])),
    );
  }

  Container buildMainContainer() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: newTransactionMainFrontContainerColor,
        ),
        height: 550,
        width: 340,
        child: Column(
          children: [
            SizedBox(height: 50),
            buildTransactionNameDropdown(),
            SizedBox(height: 30),
            buildTransactionDetailsTextField(),
            SizedBox(height: 30),
            buildTransactionAmountTextField(),
            SizedBox(height: 30),
            buildTransactionTypeDropdown(),
            SizedBox(height: 30),
            buildTransactionDatePicker(),
            SizedBox(height: 30),
            Spacer(),
            buildSaveButton(),
            SizedBox(height: 20),
          ],
        ));
  }

  Widget buildSaveButton() {
    return GestureDetector(
      onTap: () {
        var transaction = Transaction(
            selectedTransactionName!,
            transactionDetailsTEC.text,
            double.parse(transactionAmountTEC.text),
            selectedTransactionType!,
            selectedDateTime);
        hiveBox.add(transaction);
        // this will return to previous screen. will
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: newTransactionSaveButtonColor,
        ),
        width: 120,
        height: 50,
        child: Text(
          'Save',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: newTransactionSaveButtonTextColor,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Padding buildTransactionNameDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      // this is the container with the dropdown
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: 320,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 2,
                  color: newTransactionFormElementsEnabledBorderColor)),
          child: DropdownButton<String>(
            value: selectedTransactionName,
            onChanged: ((value) {
              setState(() {
                selectedTransactionName = value!;
              });
            }),
            items: _transactionNameDropdownValues
                .map((x) => DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                                width: 40,
                                child: Image.asset(
                                    'images/dropdown/transaction_names/${x.replaceAll(' ', '_').toLowerCase()}.png')),
                            SizedBox(width: 10),
                            Text(
                              x,
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      value: x,
                    ))
                .toList(),
            hint: Text(
              'Name',
              style: TextStyle(color: newTransactionPlaceholderColor),
            ),
            dropdownColor: newTransactionDropdownContainerColor,
            isExpanded: true,
          )),
    );
  }

  Padding buildTransactionDetailsTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: transactionDetailsTEC,
        focusNode: transactionDetailsFocusNode,
        // text box = input decoration
        decoration: InputDecoration(
            contentPadding:
                // edge insets = immutable set of offsets in all 4 card pts
                EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            labelText: "Details",
            labelStyle:
                TextStyle(fontSize: 17, color: newTransactionPlaceholderColor),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 2,
                    color: newTransactionFormElementsEnabledBorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 2,
                    color: newTransactionFormElementsFocusedBorderColor))),
      ),
    );
  }

  Padding buildTransactionAmountTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        // this is how to stop users from inputting letters
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        controller: transactionAmountTEC,
        focusNode: transactionAmountFocusNode,
        // text box = input decoration
        decoration: InputDecoration(
            contentPadding:
                // edge insets = immutable set of offsets in all 4 card pts
                EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            labelText: "Amount",
            labelStyle:
                TextStyle(fontSize: 17, color: newTransactionPlaceholderColor),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 2,
                    color: newTransactionFormElementsEnabledBorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 2,
                    color: newTransactionFormElementsFocusedBorderColor))),
      ),
    );
  }

  Padding buildTransactionTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      // this is the container with the dropdown
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: 320,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 2,
                  color: newTransactionFormElementsEnabledBorderColor)),
          child: DropdownButton<String>(
            value: selectedTransactionType,
            onChanged: ((value) {
              setState(() {
                selectedTransactionType = value!;
              });
            }),
            items: _transactionTypeDropdownValues
                .map((x) => DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                                width: 40,
                                child: Image.asset(
                                    'images/dropdown/transaction_types/${x.toLowerCase()}.png')),
                            SizedBox(width: 10),
                            Text(
                              x,
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      value: x,
                    ))
                .toList(),
            hint: Text(
              'Transaction Type',
              style: TextStyle(color: newTransactionPlaceholderColor),
            ),
            dropdownColor: newTransactionDropdownContainerColor,
            isExpanded: true,
          )),
    );
  }

  Container buildTransactionDatePicker() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 2, color: newTransactionFormElementsEnabledBorderColor)),
      width: 310,
      child: TextButton(
        onPressed: () async {
          DateTime? newDateTime = await showDatePicker(
              context: context,
              initialDate: selectedDateTime,
              firstDate: DateTime(2022),
              lastDate: DateTime(2100));
          if (newDateTime == null) return;
          setState(() {
            selectedDateTime = newDateTime;
          });
        },
        child: Text(
          'Date: ${selectedDateTime.day} / ${selectedDateTime.month} / ${selectedDateTime.year}',
          style: TextStyle(
            fontSize: 15,
            color: newTransactionDateTextColor,
          ),
        ),
      ),
    );
  }

  Column buildBackgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              color: newTransactionTopContainerColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back,
                            color: newTransactionBackArrowIconColor)),
                    Text(
                      'Adding',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: newTransactionTitleColor),
                    ),
                    Icon(Icons.attach_file_outlined,
                        color: newTransactionAttachmentIconColor),
                  ],
                ),
              )
            ])),
      ],
    );
  }
}
