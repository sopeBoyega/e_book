import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart'; // import your OrderModel

class OrderService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<OrderModel>> getUserOrders() {
    final uid = _auth.currentUser!.uid;

    return _db
        .collection('orders')
        .where('userId', isEqualTo: uid) // fetch only current user's orders
        .orderBy('date', descending: true) // latest orders first
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.id, doc.data()))
        .toList());
  }
}
