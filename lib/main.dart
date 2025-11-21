// lib/main.dart
import 'package:e_book/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/cart_provider.dart';
import 'screens/main_shell.dart';
// if you still need it elsewhere, keep this import
import 'screens/login_screen.dart';

Future<void> main() async {
  // Make sure Flutter is ready before async work
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase once, before runApp
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const EBookApp());
}

class EBookApp extends StatelessWidget {
  const EBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'E-Book Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: const Color(0xFFF2F2F2),
        ),
        // Use the shell as the first screen so the app actually shows something
        home: const LoginScreen(),
      ),
    );
  }
}
