import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final String price; // Stored as String in model, converted to double for Firestore
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

  // Used to ensure the Set correctly identifies duplicate books based on ID.
  @override
  bool operator ==(Object other) => 
      identical(this, other) || other is Book && runtimeType == other.runtimeType && id == other.id;

  // “I override equality so that books with the same ID are treated as the same book. That way, when I put them in a Set, duplicates are removed automatically.”
  @override
  int get hashCode => id.hashCode;



  // Helper method to convert the Book object into a Firestore Map
  Map<String, dynamic> toFirestoreMap() {
    return {
      'title': title,
      'author': author,
      'category': category,
      // Convert price string to double for better storage and querying
      'price': double.tryParse(price) ?? 0.0, 
      'imagePath': imagePath,
      'rating': rating,
      'description': description,
      'addedAt': Timestamp.now(), // Automatically add a timestamp for ordering
    };
  }
}

// ----------------------------------------------------------------------
// 2. HOME DATA (Provided by user - truncated for brevity)
// ----------------------------------------------------------------------

class HomeData {
  // Combine all lists into a single collection for easy iteration
  static final List<List<Book>> allBookLists = [
    bestDeals,
    topBooksThisWeek,
    topBooksThisMonth,
    topBooksThisYear,
    latestBooks,
    upcomingBooks,
  ];

  static final List<Book> bestDeals = [
    Book(
      id: 'deal1',
      title: 'Sunsets with Annie',
      author: 'Mindset',
      category: 'Novel',
      price: '33.00',
      imagePath: 'assets/images/book5.png',
      rating: 4.2,
      description: "...",
    ),
    Book(
      id: 'deal2',
      title: 'Zodiac Academy',
      author: 'Caroline Peckham',
      category: 'Fantasy',
      price: '29.00',
      imagePath: 'assets/images/book4.png',
      rating: 4.4,
      description: "...",
    ),
    Book(
      id: 'deal3',
      title: 'The Picture of Dorian Gray',
      author: 'Oscar Wilde',
      category: 'Fiction',
      price: '23.00',
      imagePath: 'assets/images/book1.jpg',
      rating: 4.11,
      description: "...",
    ),
    Book(
      id: 'deal4',
      title: 'Nine Liars',
      author: 'Maureen Johnson',
      category: 'Mystery',
      price: '20.00',
      imagePath: 'assets/images/book3.png',
      rating: 4.0,
      description: "...",
    ),
    Book(
      id: 'deal5',
      title: 'The Ultimate Anxiety Free Collection',
      author: '',
      category: 'Non-fiction',
      price: '15.00',
      imagePath: 'assets/images/book6.png',
      rating: 4.3,
      description: "...",
    ),
  ];

  static final List<Book> topBooksThisWeek = [
    Book(
      id: 'top1',
      title: 'The Picture of Dorian Gray',
      author: 'Oscar Wilde',
      category: 'Gothic fiction',
      price: '25.00',
      imagePath: 'assets/images/book1.jpg',
      rating: 4.11,
      description: "...",
    ),
    Book(
      id: 'top2',
      title: 'The Catcher in the Rye',
      author: 'J.D. Salinger',
      category: 'Classics',
      price: '30.00',
      imagePath: 'assets/images/book2.png',
      rating: 3.9,
      description: "...",
    ),
    // ... other lists are included but omitted for brevity
    // All unique books will be collected in the import function.
  ];
  
  static final List<Book> topBooksThisMonth = [
     Book(
      id: 'tm1',
      title: 'Sorrow and Starlight',
      author: 'Caroline Peckham, Susanne Valenti',
      category: 'Fantasy',
      price: '30.00',
      imagePath: 'assets/images/book10.png',
      rating: 4.5,
      description: "...",
    ),
    Book(
      id: 'tm2',
      title: 'Queen of Myth and Monsters',
      author: 'Scarlett St. Clair',
      category: 'Fantasy',
      price: '28.00',
      imagePath: 'assets/images/book11.jpg',
      rating: 4.2,
      description: "...",
    ),
    Book(
      id: 'tm3',
      title: 'The Ultimate Anxiety Free Collection',
      author: '',
      category: 'Non-fiction',
      price: '15.00',
      imagePath: 'assets/images/book6.png',
      rating: 4.3,
      description: "...",
    ),
  ];
  
  static final List<Book> topBooksThisYear = [
    Book(
      id: 'ty1',
      title: 'Nine Liars',
      author: 'Maureen Johnson',
      category: 'Mystery',
      price: '20.00',
      imagePath: 'assets/images/book3.png',
      rating: 4.0,
      description: "...",
    ),
    Book(
      id: 'ty2',
      title: 'Harry Potter and the Philosopher\'s Stone',
      author: 'J. K. Rowling',
      category: 'Fantasy',
      price: '24.00',
      imagePath: 'assets/images/book12.jpg',
      rating: 4.0,
      description: "...",
    ),
    Book(
      id: 'ty3',
      title: 'Harry Potter and the Deathly Hallows',
      author: 'J. K. Rowling',
      category: 'Fantasy',
      price: '21.00',
      imagePath: 'assets/images/book13.jpg',
      rating: 4.1,
      description: "...",
    ),
  ];
  
  static final List<Book> latestBooks = [
    Book(
      id: 'latest1',
      title: 'Nine Liars',
      author: 'Maureen Johnson',
      category: 'Young adult',
      price: '16.00',
      imagePath: 'assets/images/book3.png',
      rating: 4.0,
      description: "...",
    ),
    Book(
      id: 'latest2',
      title: 'Sorrow and Starlight',
      author: 'Caroline Peckham, Susanne Valenti',
      category: 'Fantasy',
      price: '30.00',
      imagePath: 'assets/images/book10.png',
      rating: 4.5,
      description: "...",
    ),
    Book(
      id: 'latest3',
      title: 'Sunsets with Annie',
      author: 'Mindset',
      category: 'Young adult',
      price: '33.00',
      imagePath: 'assets/images/book5.png',
      rating: 4.2,
      description: "...",
    ),
    Book(
      id: 'latest4',
      title: 'The Ultimate Anxiety Free Collection',
      author: '',
      category: 'Non-fiction',
      price: '15.00',
      imagePath: 'assets/images/book6.png',
      rating: 4.3,
      description: "...",
    ),
  ];
  
  static final List<Book> upcomingBooks = [
    Book(
      id: 'upcoming1',
      title: 'Queen of Myth and Monsters',
      author: 'Scarlett St. Clair',
      category: 'Fantasy',
      price: '28.00',
      imagePath: 'assets/images/book11.jpg',
      rating: 4.2,
      description: "...",
    ),
    Book(
      id: 'upcoming2',
      title: 'Sorrow and Starlight',
      author: 'Caroline Peckham, Susanne Valenti',
      category: 'Fantasy',
      price: '30.00',
      imagePath: 'assets/images/book10.png',
      rating: 4.5,
      description: "...",
    ),
    Book(
      id: 'upcoming3',
      title: 'Harry Potter and the Goblet of Fire',
      author: 'J. K. Rowling',
      category: 'Fantasy',
      price: '24.00',
      imagePath: 'assets/images/book14.jpg',
      rating: 4.0,
      description: "...",
    ),
    Book(
      id: 'ty3', // Note: Duplicate ID, will be filtered by the Set
      title: 'Harry Potter and the Deathly Hallows',
      author: 'J. K. Rowling',
      category: 'Fantasy',
      price: '21.00',
      imagePath: 'assets/images/book13.jpg',
      rating: 4.1,
      description: "...",
    ),
  ];
}


// ----------------------------------------------------------------------
// 3. BATCH IMPORT FUNCTION
// ----------------------------------------------------------------------

/// Collects all unique books from HomeData and writes them to the 'books' 
/// collection in Firestore using a Batch Write for efficiency.
///
///
/// “This function imports all my sample books into Firestore. I use a Set to deduplicate them and a Firestore batch so I can write them all in one operation.”
Future<void> importAllBooks(FirebaseFirestore db) async {
  final CollectionReference booksCollection = db.collection('books');
  final batch = db.batch();
  final Set<Book> uniqueBooks = {};
  int bookCount = 0;



  // 1. Collect all unique books from all lists
  for (final bookList in HomeData.allBookLists) {
    for (final book in bookList) {
      uniqueBooks.add(book);
    }
  }

  print('Found ${uniqueBooks.length} unique books to import.');

  // 2. Iterate over the unique books and add them to the batch
  for (final book in uniqueBooks) {
    // Use the book's ID as the document ID
    final docRef = booksCollection.doc(book.id);
    
    // Use the toFirestoreMap helper to prepare the data
    batch.set(docRef, book.toFirestoreMap());
    bookCount++;
  }
  
  // 3. Commit the batch
  try {
    print('Starting batch write...');
    await batch.commit();
    print('✅ Successfully committed $bookCount documents to the "books" collection.');
  } catch (e) {
    print('❌ ERROR during batch import: $e');
  }
}


// ----------------------------------------------------------------------
// 4. EXAMPLE USAGE (You would integrate this call into your app startup)
// ----------------------------------------------------------------------

/*
// Assuming Firebase is initialized elsewhere:
// final db = FirebaseFirestore.instance;
// importAllBooks(db); 
*/