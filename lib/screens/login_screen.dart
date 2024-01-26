// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_inventory/notifiers/auth_notifier.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Flutter Inventory')),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              textInput(emailController, 'Email', false),
              SizedBox(height: 16),
              textInput(passwordController, 'Password', true),
              SizedBox(height: 24),
              Consumer(builder: (context, ref, child) {
                bool isLoading = ref.watch(authNotifierProvider);

                return isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          ref
                              .read(authNotifierProvider.notifier)
                              .login(email: emailController.text, password: passwordController.text, context: context);
                        },
                        style:
                            ElevatedButton.styleFrom(backgroundColor: Colors.cyan.shade300, minimumSize: Size(160, 40)),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ));
              })
            ],
          )),
    );
  }
}

Widget textInput(TextEditingController controller, String hint, bool password) {
  return TextField(
    controller: controller,
    obscureText: password,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(16)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(16))),
  );
}
