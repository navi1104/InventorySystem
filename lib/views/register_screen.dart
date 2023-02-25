import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:navi_product_management/views/login_screen.dart';

import '../controllers/auth_controller.dart';


class RegisterScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (emailController.text.trim().isEmpty ||
                    passwordController.text.trim().isEmpty) {
                  Get.snackbar('Error', 'Please enter email and password');
                  return;
                }
                await authController.register(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: Text('Register'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Get.to(LoginScreen());
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}