// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.sumbitFn, this.isLoading})
      : super(key: key);
  final bool? isLoading;
  final void Function(
    String email,
    String username,
    String password,
    bool isAdmin,
    bool isLogin,
    BuildContext ctx,
  ) sumbitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  String _userEmail = '';
  String _username = '';
  String _userPassword = '';
  bool? _isAdmin;
  String? type;

  void _trySumbit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.sumbitFn(
        _userEmail.trim(),
        _username.trim(),
        _userPassword.trim(),
        _isAdmin!,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: const Text("employe"),
                          leading: Radio(
                              value: "employe",
                              groupValue: type,
                              onChanged: (value) {
                                setState(() {
                                  type = value.toString();
                                  _isAdmin = true;
                                });
                              }),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: const Text("client"),
                          leading: Radio(
                              value: "client",
                              groupValue: type,
                              onChanged: (value) {
                                setState(() {
                                  type = value.toString();
                                  _isAdmin = false;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: ((value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return ' Please enter Valid Email address';
                      }
                      return null;
                    }),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Adress',
                    ),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: ((value) {
                        if (value!.isEmpty || value.length < 4) {
                          return ' Password must be at least 4 characters long';
                        }
                        return null;
                      }),
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 7) {
                        return ' Password must be 7 characters long';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading!) const CircularProgressIndicator(),
                  if (!widget.isLoading!)
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        _isLogin ? 'Login' : 'Sign Up',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _trySumbit,
                    ),
                  TextButton(
                    child: const Text(
                      'Create new account',
                      style: TextStyle(
                        color: Colors.pink,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
