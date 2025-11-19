import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import 'book_detail_screen.dart';

class CategoryBooksScreen extends StatelessWidget {
  final String categoryName;
  final List<Book> books;

  const CategoryBooksScreen({
    super.key,
    required this.categoryName,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: books.isEmpty
            ? const Center(
          child: Text(
            'No books in this category yet.',
            style: TextStyle(fontSize: 14),
          ),
        )
            : ListView.separated(
          itemCount: books.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final book = books[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookDetailScreen(book: book),
                  ),
                );
              },
              child: BookCard(book: book),
            );
          },
        ),
      ),
    );
  }
}
