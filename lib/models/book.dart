class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final String price;
  final String imagePath;

  // Rating & Description
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


  //  factory Book.fromMap(String id, Map<String, dynamic> map) {
  //   return Book(
  //     id: id,
  //     title: map['title'] ?? '',
  //     author: map['author'] ?? '',
  //     price: (map['price'] ?? 0) is int ? map['price'] : int.tryParse(map['price'].toString()) ?? 0,
  //     imageUrl: map['imageUrl'],
  //     description: map['description'],
  //   );
  // }


}
