import 'package:finances_tracker_app_ss_flutter/widgets/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // if the user is authenticated then stream builder will return the user
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // this checks if the value from the stream contains any user
        if (!snapshot.hasData) {
          // if not return sign in screen
          // Sign in screen functionality: allow sign in, forgot password option, register option
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(
                  clientId:
                  '205748873722-0qdfkj639cmcqsng651dj4e1aoafhg3s.apps.googleusercontent.com'),
            ],
            // this will only be shown on mobile / tall screens
            // Specifically, if a screen is more than 800 pixels wide, the side builder content is shown,
            // and the header content is not.
            // If the screen is less than 800 pixels wide, the opposite is true.
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset('images/product-logos/flutterfire_300x.png')));
            },
            subtitleBuilder: (context, action) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: action == AuthAction.signIn
                      ? const Text('Welcome to FinanceTracker, please sign in!')
                      : const Text('Welcome fo FinanceTracker, please sign up!'));
            },
            footerBuilder: (context, action) {
              return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'By signing in you agree to our terms and conditions.',
                    style: TextStyle(color: Colors.grey),
                  ));
            },
            // this will be shown only on wide screens, desktop, web
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('images/product-logos/flutterfire_300x.png'),
                ),
              );
            },
          );
        }
        // is there is a user go to home screen
        return const BottomNav();
      },
    );
  }
}