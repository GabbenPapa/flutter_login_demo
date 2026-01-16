import 'package:flutter/material.dart';
import '../widget/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  void _handleAuthSubmit(bool isLogin) async {
    setState(() => _isLoading = true);

    // Fake delay for demo purposes
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isLogin ? 'Fake login successful' : 'Fake registration successful'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );

    // Navigate to the next screen (Skeleton)
    // Navigator.of(context).pushReplacementNamed('/home');
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