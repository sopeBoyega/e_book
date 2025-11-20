import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> createIfNotExists({required String name}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _db.collection('users').doc(user.uid);
    final snap = await docRef.get();
    if (!snap.exists) {
      await docRef.set({
        'email': user.email ?? '',
        'name': name,
        'phone': '',
        'photoUrl': '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUserDoc() {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('No logged-in user');
    }
    return _db.collection('users').doc(user.uid).snapshots();
  }

  Future<void> updateProfile({
    required String name,
    required String photoUrl,
    String? phone,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final data = {'name': name, 'photoUrl': photoUrl};
    if (phone != null) data['phone'] = phone;

    await _db.collection('users').doc(user.uid).update(data);
  }
}
