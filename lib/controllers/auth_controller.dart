import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../views/home_screen.dart';
import '../views/login_screen.dart';

class AuthController extends GetxController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Rx<User?> _firebaseUser = Rx<User?>(null);
  late Rx<User?> _firebaseUser;

  @override
  void onReady() {
    super.onReady();
    _firebaseUser = Rx<User?>(_firebaseAuth.currentUser);
    _firebaseUser.bindStream(_firebaseAuth.authStateChanges());
    ever(_firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  User? get user => _firebaseUser.value;

  Future<void> register(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(() => HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Registration failed",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Registration failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(() => HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Login failed",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Login failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      Get.offAll(() => LoginScreen());
    } on PlatformException catch (e) {
      Get.snackbar(
        "Sign out failed",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Sign out failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
