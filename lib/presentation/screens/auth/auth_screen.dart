// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_delivery_car/constants/colors.dart';
import 'package:smart_delivery_car/constants/strings.dart';
import '../../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _sumbitAuthForm(
    String email,
    String username,
    String password,
    bool isAdmin,
    bool isLogin,
    BuildContext context,
  ) async {
    // ignore: unused_local_variable
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance.collection('users').doc(password).set({
          'username': username,
          'email': email,
          'isAdmin': isAdmin,
        });
      }
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.redAccent,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }

    if (isAdmin) {
      Navigator.pushReplacementNamed(context, homeScreen);
    } else if (!isAdmin) {
      Navigator.pushReplacementNamed(context, clientScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: focusColorInTextField,
      body: AuthForm(
        sumbitFn: _sumbitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
