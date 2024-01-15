import 'package:finances_tracker_app_ss_flutter/Screens/statistics_screen.dart';
import 'package:finances_tracker_app_ss_flutter/Screens/home_screen.dart';
import 'package:finances_tracker_app_ss_flutter/screens/new_transaction_screen.dart';
import 'package:finances_tracker_app_ss_flutter/storage/constant_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

// by using this leading underscore => private class (only available inside this file)
class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  List screens = [
    Home(),
    Statistics(),
    Home(),
    // TODO - Why does this work without pop() ???
    ProfileScreen(
      actions: [
        SignedOutAction((context) {
          // Check if user has logged out
          print("Bye Bye");
          var user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            print('User is signed in with UID: ${user.uid}');
          } else {
            print('No user is currently signed in.');
          }
        })
      ],
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset('images/product-logos/flutterfire_300x.png'),
          ),
        ),
      ],
    )];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigator = widget - manages stack of children (actual stack)
          Navigator.of(context)
          // constructing a material page route using a builder
              .push(MaterialPageRoute(builder: (context) => NewTransaction()));
        },
        child: Icon(Icons.add),
        backgroundColor: navbarAddButtonBackgroundColor,
        foregroundColor: navbarAddButtonForegroundColor,
        // shape: ,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: selectedIndex == 0 ? navbarFocusedButtonColor : navbarDefaultButtonColor
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Icon(
                    Icons.bar_chart_outlined,
                    size: 30,
                    color: selectedIndex == 1 ? navbarFocusedButtonColor : navbarDefaultButtonColor
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 30,
                    color: selectedIndex == 2 ? navbarFocusedButtonColor : navbarDefaultButtonColor
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                },

                child: Icon(
                    Icons.person_outlined,
                    size: 30,
                    color: selectedIndex == 3 ? navbarFocusedButtonColor : navbarDefaultButtonColor
                ),
              ),
            ]
          ),
        )
      ),
    );
  }
}
