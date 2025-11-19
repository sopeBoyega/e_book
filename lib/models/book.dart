// lib/models/book.dart
class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final double price;
  final String imagePath;
  final double rating;
  final String description;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.price,
    required this.imagePath,
    this.rating = 0.0,
    this.description = '',
  });

  // ←←← ADD THIS LINE — THIS FIXES priceFormatted ERROR
  
  String get priceFormatted => '\$${price.toStringAsFixed(2)}';

  @override
  bool operator ==(Object other) => identical(this, other) || other is Book && id == other.id;

  @override
  int get hashCode => id.hashCode;
}