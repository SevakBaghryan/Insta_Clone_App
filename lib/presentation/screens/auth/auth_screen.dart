import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_app/presentation/screens/auth/signin_or_signup_screen.dart';
import 'package:insta_clone_app/presentation/screens/navigation.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NavigationScreen();
          } else {
            return const LogInOrRegister();
          }
        },
      ),
    );
  }
}
