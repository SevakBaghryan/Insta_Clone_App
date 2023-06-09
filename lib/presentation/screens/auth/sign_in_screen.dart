// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:insta_clone_app/presentation/components/button.dart';
import 'package:insta_clone_app/presentation/components/text_field.dart';
import 'package:insta_clone_app/services/auth.dart';

class SignInScreen extends StatefulWidget {
  final Function()? onTap;
  const SignInScreen({super.key, required this.onTap});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailTextController = TextEditingController();

  final passwordTextController = TextEditingController();

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Sign In and Start Chat With Your Friends',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: emailTextController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: passwordTextController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                text: 'Sign In',
                onTap: () => authService.signIn(
                  context,
                  emailTextController.text,
                  passwordTextController.text,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Haven\'t an account yet? '),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'SignUp now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
