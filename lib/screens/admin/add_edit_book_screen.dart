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
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  final BookService bookService = BookService();
  bool saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      final docData = widget.data!.data() as Map<String, dynamic>?;

      if (docData != null) {
        titleController.text = docData['title'] ?? '';
        // FIX 1: Corrected typo from 'uthor' to 'author'
        authorController.text = docData['author'] ?? '';
        categoryController.text = docData['category'] ?? "";
        
        // FIX 2: Safely convert price (stored as num/double) to String
        final rawPrice = docData['price'];
        if (rawPrice is num) {
           priceController.text = rawPrice.toString();
        } else {
           priceController.text = rawPrice?.toString() ?? '';
        }

        descriptionController.text = docData['description'] ?? '';
      }
    }
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => saving = true);

    // Parse price as double, as we agreed to store currency as numbers
    final double priceValue = double.tryParse(priceController.text.trim()) ?? 0.0;
    
    final data = {
      'title': titleController.text.trim(),
      // FIX 3: Changed 'Author' (capital A) to 'author' (lowercase a) 
      // for consistency with the importer utility
      'author': authorController.text.trim(),
      'category': categoryController.text.trim(),
      // FIX 4: Changed price storage to double to match importer utility
      'price': priceValue, 
      'description': descriptionController.text.trim(),
      // Note: Using Timestamp.now() is usually better than millisecondsSinceEpoch
      'updatedAt': FieldValue.serverTimestamp(), 
    };

    try {
      if (widget.bookId == null) {
        // Assuming addBook logic handles setting 'createdAt' if not present
        await bookService.addBook(data);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book added')));
      } else {
        await bookService.updateBook(widget.bookId!, data);
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book updated')));
      }
      Navigator.pop(context);
    } catch (e) {
      // It's good practice to log the full error for debugging
      print('Save error: $e'); 
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving book: $e')));
    } finally {
      setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.bookId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Book' : 'Add Book')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(controller: titleController, decoration: const InputDecoration(labelText: 'Title'), validator: (v) => v == null || v.isEmpty ? 'Enter title' : null),
                TextFormField(controller: authorController, decoration: const InputDecoration(labelText: 'Author'), validator: (v) => v == null || v.isEmpty ? 'Enter author' : null),
                // FIX 5: Changed the controller for Category field 
                // It was incorrectly using authorController twice.
                TextFormField(controller: categoryController, decoration: const InputDecoration(labelText: 'Category'), validator: (v) => v == null || v.isEmpty ? 'Enter Category' : null),
                TextFormField(
                  controller: priceController, 
                  decoration: const InputDecoration(labelText: 'Price'), 
                  keyboardType: const TextInputType.numberWithOptions(decimal: true), // Allow decimal input
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter price';
                    if (double.tryParse(v) == null) return 'Invalid number';
                    return null;
                  },
                ),
                TextFormField(controller: descriptionController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 3),
                const SizedBox(height: 20),
                saving ? const CircularProgressIndicator() : ElevatedButton(onPressed: save, child: Text(isEdit ? 'Update' : 'Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    categoryController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}