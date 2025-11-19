class MiracleAuth {
  static Future<void> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (username != 'test' || password != 'password123') {
      throw Exception('Invalid credentials');
    }
  }

  static Future<void> register(
    String username,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    if (username.isEmpty) throw Exception('Username taken');
  }

  static Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email != 'test@example.com') {
      throw Exception('No account found with this email');
    }
  }
}
