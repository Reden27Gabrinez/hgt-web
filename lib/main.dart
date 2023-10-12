import 'package:my_app/consts/consts.dart';
import 'package:my_app/consts/styles.dart';
import 'package:my_app/views/auth_screen/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/views/screens/category_page.dart';
import 'package:my_app/views/screens/add_product.dart';
import 'package:my_app/views/screens/add_remove_products.dart';
import 'package:my_app/views/screens/homepage.dart';
import 'package:my_app/views/screens/completed_orders.dart';
import 'package:my_app/views/screens/payment_section.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDyIg9FytYP3784AuOVm4K4QGYofdZFoe4",
          authDomain: "compra-c8725.firebaseapp.com",
          projectId: "compra-c8725",
          storageBucket: "compra-c8725.appspot.com",
          messagingSenderId: "325176695118",
          appId: "1:325176695118:web:470a718620eb609fcb661f",
          measurementId: "G-TLP8YFH46T"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // we are using getX so we have to change this material app into getmaterialapp
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
