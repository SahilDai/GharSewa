import 'package:day35/firebase_options.dart';
import 'package:day35/pages/home.dart';
import 'package:day35/pages/select_service.dart';
import 'package:day35/pages/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: StartPage(),
    debugShowCheckedModeBanner: false,
  ));
}