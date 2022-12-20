import 'package:authentication_app/Home.dart';
import 'package:authentication_app/otp.dart';
import 'package:authentication_app/phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {
      'phone': (context) => Myphone(),
      'otp': (context) => Mtotp(),
      'home': (context) => Myhome()
    },
  ));
}
