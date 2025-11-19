import 'package:e_book/firebase_options.dart';
import 'package:e_book/screens/admin/admin_books_screen.dart';
import 'package:e_book/screens/admin/admin_orders_screen.dart';
import 'package:e_book/screens/login_screen.dart';
import 'package:e_book/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/main_shell.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const EBookApp());
}

class EBookApp extends StatelessWidget {
  const EBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Book Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home:  LoginScreen(),
    );
  }
}
