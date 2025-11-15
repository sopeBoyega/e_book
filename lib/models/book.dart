class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final String price; // keep as String for now
  final String imagePath;

  // New fields for details
  final double rating;        // 0–5
  final String description;   // long text

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
}
