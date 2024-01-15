// import 'package:finances_tracker_app_ss_flutter/Screens/home_screen.dart';
// import 'package:finances_tracker_app_ss_flutter/Screens/statistics_screen.dart';
import 'package:finances_tracker_app_ss_flutter/data/transaction.dart';
import 'package:finances_tracker_app_ss_flutter/firebase/auth_gate.dart';
import 'package:finances_tracker_app_ss_flutter/firebase_options.dart';
import 'package:finances_tracker_app_ss_flutter/widgets/bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  // Firebase init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // initializes Hive with its needed data
  await Hive.initFlutter();

  // register the transaction created with build_runner based on transaction.dart
  Hive.registerAdapter(TransactionAdapter());

  // opening the box from new_transaction_screen.dart
  await Hive.openBox<Transaction>('transaction');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // this controls the debugger - it shows the debug banner if true
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      // TODO - Rename classes - include Screen as last word
      // home: Home(),
      // home: Statistics(),
      // TODO - check how to link auth with main screen
      // home: BottomNav(),
    );
  }
}
