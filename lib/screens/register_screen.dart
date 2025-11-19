import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/screens/login_screen.dart';
import 'package:e_book/screens/main_shell.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../services/auth.dart';
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
  final _userCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

   Future<void> _register() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      // show erro message
      return;
    }

    _formKey.currentState!.save();

    try {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: _emailCtrl.text,
        password: _passCtrl.text,
      ); 

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
            'username': _userCtrl,
            'email': _emailCtrl,
          });

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => MainShell()));
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
      Fluttertoast.showToast(msg: _error!);
      print(_error);
    } finally {
      setState(() => _loading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please fill your details to sign up.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  hint: 'Username',
                  validator: Validators.username,
                  onChanged: (v) => _userCtrl.text = v,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  onChanged: (v) => _emailCtrl.text = v,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hint: 'Password',
                  obscure: true,
                  validator: Validators.password,
                  onChanged: (v) => _passCtrl.text = v,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hint: 'Confirm Password',
                  obscure: true,
                  validator:
                      (v) => Validators.confirmPassword(v, _passCtrl.text),
                  onChanged: (v) => _confirmCtrl.text = v,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _loading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Register', style: AppTextStyles.button),
                ),
                Center(
                  child: TextButton(
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LoginScreen()))
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
