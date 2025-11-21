// lib/models/book.dart

class Book {
  final String id;
  final String title;
  final String author;
  final String category;

  // Stored as text, since a lot of your UI and seed data use "33.00"
  final String price;

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

  /// Factory used when reading from Firestore
  factory Book.fromMap(String id, Map<String, dynamic> data) {
    final rawPrice = data['price'];
    String priceString;

    if (rawPrice == null) {
      priceString = '0';
    } else if (rawPrice is num) {
      priceString = rawPrice.toString();
    } else {
      priceString = rawPrice.toString();
    }

    return Book(
      id: id,
      title: (data['title'] ?? '').toString(),
      author: (data['author'] ?? '').toString(),
      category: (data['category'] ?? '').toString(),
      price: priceString,
      imagePath: (data['imagePath'] ?? '').toString(),
      rating: (data['rating'] is num)
          ? (data['rating'] as num).toDouble()
          : 0.0,
      description: (data['description'] ?? '').toString(),
    );
  }

  /// Use this for calculations
  double get priceValue => double.tryParse(price) ?? 0.0;

  /// Use this for pretty display
  String get priceFormatted => '\$${priceValue.toStringAsFixed(2)}';
}
