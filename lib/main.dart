import 'package:flutter/material.dart';
import 'projectapp/Home.dart';
import 'projectapp/Add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

routes: {
        '/':(context)=>Homepage(),
  '/add':(context)=>AddUsers(),
},
      initialRoute: '/',
    );
  }
}