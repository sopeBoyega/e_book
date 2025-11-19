import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  final CollectionReference books = FirebaseFirestore.instance.collection('books');

  Future<void> addBook(Map<String, dynamic> data) async {
    await books.add(data);
  }

  Future<void> updateBook(String id, Map<String, dynamic> data) async {
    await books.doc(id).update(data);
  }

  Future<void> deleteBook(String id) async {
    await books.doc(id).delete();
  }
}
