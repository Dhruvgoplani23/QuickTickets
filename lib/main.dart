import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quickticket/models/routes.dart';
import 'package:quickticket/screens/boughtpassscreen.dart';
import 'package:quickticket/screens/loding_screen.dart';
import 'package:quickticket/screens/newsignin.dart';
import 'package:quickticket/screens/profile_page.dart';
import 'screens/firebase_options.dart';
import 'screens/homepage.dart';
import 'screens/busresults.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'screens/aboutus.dart';
import 'screens/passpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick ticket',
      home: const homepage(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.teal[300],
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black
            ),
            backgroundColor: Color(0xff6ABCAB),
          )),
    );
  }
}

