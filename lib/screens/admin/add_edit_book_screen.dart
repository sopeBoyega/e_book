import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/book_service.dart';

class AddEditBookScreen extends StatefulWidget {
  final String? bookId;
  final DocumentSnapshot? data;

  const AddEditBookScreen({super.key, this.bookId, this.data});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  final BookService bookService = BookService();
  bool saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      titleController.text = widget.data!['title'] ?? '';
      authorController.text = widget.data!['author'] ?? '';
      priceController.text = (widget.data!['price'] ?? '').toString();
      descriptionController.text = widget.data!['description'] ?? '';
    }
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => saving = true);

    final data = {
      'title': titleController.text.trim(),
      'author': authorController.text.trim(),
      'price': int.tryParse(priceController.text.trim()) ?? 0,
      'description': descriptionController.text.trim(),
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    };

    try {
      if (widget.bookId == null) {
        await bookService.addBook(data);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book added')));
      } else {
        await bookService.updateBook(widget.bookId!, data);
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book updated')));
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.bookId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Book' : 'Add Book')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: titleController, decoration: const InputDecoration(labelText: 'Title'), validator: (v) => v == null || v.isEmpty ? 'Enter title' : null),
              TextFormField(controller: authorController, decoration: const InputDecoration(labelText: 'Author'), validator: (v) => v == null || v.isEmpty ? 'Enter author' : null),
              TextFormField(controller: priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
              TextFormField(controller: descriptionController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 3),
              const SizedBox(height: 20),
              saving ? const CircularProgressIndicator() : ElevatedButton(onPressed: save, child: Text(isEdit ? 'Update' : 'Add')),
            ],
          ),
        ),
      ),
    );
  }
}
