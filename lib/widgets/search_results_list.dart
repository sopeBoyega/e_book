import 'package:flutter/material.dart';
import '../models/book.dart';
import 'book_card.dart';

class SearchResultsList extends StatelessWidget {
  final List<Book> books;
  final String searchQuery;
  final ValueChanged<Book> onBookTap;

  const SearchResultsList({
    super.key,
    required this.books,
    required this.searchQuery,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Center(
        child: Text(
          'No books found for "$searchQuery".',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: books.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () => onBookTap(book),
          child: BookCard(book: book),
        );
      },
    );
  }
}
