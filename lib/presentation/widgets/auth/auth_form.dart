// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_delivery_car/constants/colors.dart';

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
  String pass = '';

  void _trySumbit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      if (_isLogin) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_userPassword)
            .get()
            .then((value) {
          Map data = value.data() as Map;
          print(data['isAdmin']);
          _isAdmin = data['isAdmin'];
        });
      }

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

  buildChooseAdminOrClientWidget() {
    return Row(
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
    );
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
                  if (!_isLogin) buildChooseAdminOrClientWidget(),
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
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (value) {
                      pass = value;
                      print(pass);
                    },
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
                        backgroundColor: onBoardingTextButtonColor,
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
                    child: Text(
                      _isLogin ? 'Create new account' : 'Log In',
                      style: const TextStyle(
                        color: onBoardingTextColor,
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
