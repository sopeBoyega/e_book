import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/screens/login_screen.dart';
import 'package:e_book/screens/main_shell.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_text_field.dart';

final _firebase = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  bool _loading = false;
  String? _error;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      // 1️⃣ Create Firebase user
      final userCred = await _firebase.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // 2️⃣ Save user in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set({
        'uid': userCred.user!.uid,
        'name': username.trim(),
        'email': email.trim(),
        'photoUrl': '',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3️⃣ Navigate into app
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => MainShell()),
            (route) => false,
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Please fill your details to sign up.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 32),

                // Username
                CustomTextField(
                  hint: 'Username',
                  validator: Validators.username,
                  onChanged: (v) => username = v,
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  onChanged: (v) => email = v,
                ),
                const SizedBox(height: 16),

                // Password
                CustomTextField(
                  hint: 'Password',
                  obscure: true,
                  validator: Validators.password,
                  onChanged: (v) => password = v,
                ),
                const SizedBox(height: 16),

                // Confirm Password
                CustomTextField(
                  hint: 'Confirm Password',
                  obscure: true,
                  validator: (v) => Validators.confirmPassword(v, password),
                  onChanged: (v) => confirmPassword = v,
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _loading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Register', style: AppTextStyles.button),
                ),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Already a member? Sign in',
                      style: AppTextStyles.link,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
