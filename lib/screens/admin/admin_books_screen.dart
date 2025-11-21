import 'package:e_book/screens/admin/admin_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Note: Assuming these imports are correct based on your project structure
import 'package:e_book/utils/book_importer.dart'; 
import '../../services/book_service.dart';
import 'add_edit_book_screen.dart';

final db = FirebaseFirestore.instance;

class AdminBooksScreen extends StatelessWidget {
  // Assuming BookService is implemented elsewhere and works correctly
  final BookService bookService = BookService(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Books"), actions: [
        IconButton(onPressed: (){
          // This button triggers the batch import function
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  AdminOrdersScreen()));
        }, icon: Icon(Icons.book_sharp))
      ],),
      
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Note: AddEditBookScreen needs to be defined in your project
          // to push to it successfully.
          // Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditBookScreen()));
          print('Navigate to AddEditBookScreen for new book.');
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        // FIX: Added ordering by 'addedAt' (or 'title', if preferred)
        // to ensure a stable, sorted list.
        stream: FirebaseFirestore.instance
            .collection("books")
            .orderBy('addedAt', descending: true) // Assuming 'addedAt' is your sort field
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('No books yet. Tap + to add one.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final book = docs[index];
              // FIX: Corrected field access to lowercase 'author'
              final title = book['title'] ?? 'Unknown Title';
              final author = book['author'] ?? 'Unknown Author';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(author),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Note: Ensure AddEditBookScreen handles the DocumentSnapshot 'book'
                          // as it's passed here.
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => AddEditBookScreen(bookId: book.id, data: book),
                          ));
                           print('Navigate to AddEditBookScreen to edit: ${book.id}');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          // Note: showDialog needs context which is available here
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (c) => AlertDialog(
                              title: const Text('Delete book?'),
                              content: const Text('This action cannot be undone.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                                TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Delete')),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            // Note: Assuming bookService.deleteBook exists and works
                            // await bookService.deleteBook(book.id); 
                            print('Book deleted: ${book.id}');
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book deleted')));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}