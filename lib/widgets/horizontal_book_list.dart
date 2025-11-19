import 'package:flutter/material.dart';
import '../models/book.dart';
import 'book_card.dart';

class HorizontalBookList extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onBookTap;

  const HorizontalBookList({
    super.key,
    required this.books,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () => onBookTap(book),
            child: BookCard(book: book),
          );
        },
      ),
    );
  }
}
