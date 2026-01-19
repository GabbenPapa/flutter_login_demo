import 'package:flutter/material.dart';
import 'package:driver_app_demo/components/inputs.dart';

class LoginForm extends StatefulWidget {
  final void Function(String email, String password, bool isLogin) onSubmit;
  final bool isLoading;

  const LoginForm({
    required this.onSubmit,
    required this.isLoading,
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _username = '';
  String _password = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.onSubmit(_email.trim(), _password.trim(), _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'lib/assets/facts-logo.png',
          height: 100, 
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextInput(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'E-Mail address',
                    validator: (value) {
                      if (value == null || !value.contains('@')) return 'Invalid email';
                      return null;
                    },
                    onSaved: (value) => _email = value ?? '',
                  ),
                  const SizedBox(height: 10),
                  if (!_isLogin) ...[
                    TextInput(
                      key: const ValueKey('username'),
                      textCapitalization: TextCapitalization.words,
                      labelText: 'Username',
                      validator: (value) => (value == null || value.length < 4) 
                          ? 'Please enter a valid username' : null,
                      onSaved: (value) => _username = value!,
                    ),
                    const SizedBox(height: 10),
                  ],
                  TextInput(
                    key: const ValueKey('password'),
                    obscureText: true,
                    labelText: 'Password',
                    validator: (value) {
                      if (value == null || value.length < 4) return 'Too short';
                      return null;
                    },
                    onSaved: (value) => _password = value ?? '',
                  ),
                  const SizedBox(height: 20),
                  if (widget.isLoading)
                    const CircularProgressIndicator()
                  else ...[
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Sign up'),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _isLogin = !_isLogin),
                      child: Text(_isLogin ? 'Create account' : 'I have an account'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}