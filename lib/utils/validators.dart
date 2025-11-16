class Validators {
  static String? required(String? v) => v?.isEmpty ?? true ? 'Required' : null;
  static String? username(String? v) =>
      (v?.isEmpty ?? true) ? 'Enter username' : null;
  static String? email(String? v) {
    if (v == null || v.isEmpty) return 'Enter email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) return 'Invalid email';
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Enter password';
    if (v.length < 6) return 'Min 6 characters';
    return null;
  }

  static String? confirmPassword(String? v, String original) {
    if (v != original) return 'Passwords do not match';
    return null;
  }
}
