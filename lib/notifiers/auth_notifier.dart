import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inventory/screens/home_screen.dart';
import 'package:flutter_inventory/screens/login_screen.dart';
import 'package:flutter_inventory/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, bool>((ref) => AuthNotifier(ref.watch(authServiceProvider)));

class AuthNotifier extends StateNotifier<bool> {
  final AuthService _authService;
  AuthNotifier(this._authService) : super(false);

  login({required String email, required String password, required BuildContext context}) async {
    try {
      state = true;

      await _authService.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeView()));

      state = false;
    } catch (e) {
      state = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error message: $e')));
    }
  }

  logout({required BuildContext context}) async {
    try {
      await _authService.signOut();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginView()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error message: $e')));
    }
  }

  User? getUser() {
    return _authService.currentUser;
  }
}
