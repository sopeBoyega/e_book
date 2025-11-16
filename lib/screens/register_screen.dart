import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../services/miracle_auth.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_text_field.dart';

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
    if (!_formKey.currentState!.validate()) return;
    if (_passCtrl.text != _confirmCtrl.text) {
      Fluttertoast.showToast(msg: 'Passwords do not match');
      return;
    }
    setState(() => _loading = true);
    try {
      await MiracleAuth.register(
        _userCtrl.text,
        _emailCtrl.text,
        _passCtrl.text,
      );
      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      setState(() => _error = e.toString());
      Fluttertoast.showToast(msg: _error!);
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
                    onPressed: () => context.go('/login'),
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
