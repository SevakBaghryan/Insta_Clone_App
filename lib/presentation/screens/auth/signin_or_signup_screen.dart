import 'package:flutter/material.dart';
import 'package:insta_clone_app/presentation/screens/auth/sign_in_screen.dart';
import 'package:insta_clone_app/presentation/screens/auth/sign_up_screen.dart';

class LogInOrRegister extends StatefulWidget {
  const LogInOrRegister({super.key});

  @override
  State<LogInOrRegister> createState() => _LogInOrRegisterState();
}

class _LogInOrRegisterState extends State<LogInOrRegister> {
  bool showSignInScreen = true;

  void toggleScreens() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignInScreen) {
      return SignInScreen(onTap: toggleScreens);
    } else {
      return SignUpScreen(
        onTap: toggleScreens,
      );
    }
  }
}
