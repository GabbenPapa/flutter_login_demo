import 'package:chat_app/components/inputs.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final void Function(bool isLogin) onSubmit;
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
  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (!isValid) return;

    _formKey.currentState!.save();

    widget.onSubmit(_isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInput(
                key: const ValueKey('email'),
                autocorrection: false,
                labelText: 'E-Mail',
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || !value.contains('@')) 
                    ? 'Please enter a valid email address' : null,
                onSaved: (value) => _userEmail = value!,
              ),
              if (!_isLogin) ...[
                const SizedBox(height: 10),
                TextInput(
                  key: const ValueKey('username'),
                  textCapitalization: TextCapitalization.words,
                  labelText: 'Username',
                  validator: (value) => (value == null || value.length < 4) 
                      ? 'Please enter a valid username' : null,
                  onSaved: (value) => _userName = value!,
                ),
              ],
              const SizedBox(height: 10),
              TextInput(
                key: const ValueKey('password'),
                labelText: 'Password',
                obscureText: true,
                validator: (value) => (value == null || value.length < 7) 
                    ? 'Password must be at least 7 characters long' : null,
                onSaved: (value) => _userPassword = value!,
              ),
              const SizedBox(height: 12),
              if (widget.isLoading)
                const CircularProgressIndicator()
              else ...[
                ElevatedButton(
                  onPressed: _trySubmit,
                  child: Text(_isLogin ? 'Login' : 'Sign up'),
                ),
                TextButton(
                  onPressed: () => setState(() => _isLogin = !_isLogin),
                  child: Text(_isLogin 
                      ? 'Create new account' 
                      : 'I have an existing account'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
