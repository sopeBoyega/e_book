import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../services/miracle_auth.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _showPass = false;
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await MiracleAuth.login(_usernameCtrl.text, _passCtrl.text);
      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
      Fluttertoast.showToast(msg: _error!);
    } finally {
      setState(() => _loading = false);
    }
  }

  // final snapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(cred.user!.uid)
  //         .get();

  //     final role = snapshot.data()?['role'] ?? 'user';


  void _showForgotPasswordDialog() {
    final emailCtrl = TextEditingController();
    final dialogKey = GlobalKey<FormState>();
    bool dlgLoading = false;
    String? dlgError;

    showDialog(
      context: context,
      builder:
          (_) => StatefulBuilder(
            builder:
                (ctx, setDlg) => AlertDialog(
                  title: const Text('Reset Password'),
                  content: Form(
                    key: dialogKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          hint: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                          onChanged: (v) => emailCtrl.text = v,
                        ),
                        if (dlgError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              dlgError!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed:
                          dlgLoading
                              ? null
                              : () async {
                                if (!dialogKey.currentState!.validate()) return;
                                setDlg(() => dlgLoading = true);
                                try {
                                  await MiracleAuth.resetPassword(
                                    emailCtrl.text,
                                  );
                                  if (!mounted) return;
                                  Navigator.pop(ctx);
                                  Fluttertoast.showToast(
                                    msg: 'Reset link sent',
                                  );
                                } catch (e) {
                                  setDlg(
                                    () =>
                                        dlgError = e.toString().replaceFirst(
                                          'Exception: ',
                                          '',
                                        ),
                                  );
                                } finally {
                                  setDlg(() => dlgLoading = false);
                                }
                              },
                      child:
                          dlgLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : const Text('Send'),
                    ),
                  ],
                ),
          ),
    );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please fill your details to login.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 32),
              CustomTextField(
                hint: 'Username/email',
                validator: Validators.required,
                onChanged: (v) => _usernameCtrl.text = v,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: 'Password',
                obscure: !_showPass,
                suffix: IconButton(
                  icon: Icon(
                    _showPass ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _showPass = !_showPass),
                ),
                validator: Validators.password,
                onChanged: (v) => _passCtrl.text = v,
              ),
              const SizedBox(height: 24),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading ? null : _login,
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
                        : const Text(
                          'Get Started',
                          style: AppTextStyles.button,
                        ),
              ),
              Center(
                child: TextButton(
                  onPressed: _showForgotPasswordDialog,
                  child: const Text(
                    'Forgot password?',
                    style: AppTextStyles.link,
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () => context.go('/register'),
                  child: const Text(
                    'New member? Register',
                    style: AppTextStyles.link,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
