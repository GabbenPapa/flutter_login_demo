import 'package:flutter/material.dart';
import '../widget/login_form.dart';
import 'vehicle_selection_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  void _handleAuthSubmit(String email, String password, bool isLogin) async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isLogin ? 'Welcome back, $email!' : 'Registration successful!'),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pushReplacementNamed(VehicleSelectionScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: LoginForm(
            onSubmit: _handleAuthSubmit,
            isLoading: _isLoading,
          ),
        ),
      ),
    );
  }
}