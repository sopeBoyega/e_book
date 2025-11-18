import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import 'book_detail_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  // ------------ CATEGORY DATA ------------

  static const List<_CategoryItem> _categories = [
    _CategoryItem(
      name: 'Non-fiction',
      imagePath: 'assets/images/category_nonfiction.png',
    ),
    _CategoryItem(
      name: 'Classics',
      imagePath: 'assets/images/category_classics.png',
    ),
    _CategoryItem(
      name: 'Fantasy',
      imagePath: 'assets/images/category_fantasy.png',
    ),
    _CategoryItem(
      name: 'Young Adult',
      imagePath: 'assets/images/category_young_adult.png',
    ),
    _CategoryItem(
      name: 'Crime',
      imagePath: 'assets/images/category_crime.png',
    ),
    _CategoryItem(
      name: 'Horror',
      imagePath: 'assets/images/category_horror.png',
    ),
    _CategoryItem(
      name: 'Sci-fi',
      imagePath: 'assets/images/category_scifi.png',
    ),
    _CategoryItem(
      name: 'Drama',
      imagePath: 'assets/images/category_drama.png',
    ),
  ];

  // ------------ BOOKS BY CATEGORY ------------

  // These reuse the same titles/covers you already have in HomeScreen
  static const Map<String, List<Book>> _booksByCategory = {
    'Non-fiction': [
      Book(
        id: 'nf1',
        title: 'The Ultimate Anxiety Free Collection',
        author: '',
        category: 'Non-fiction',
        price: 15.00,
        imagePath: 'assets/images/book6.png',
        rating: 4.3,
        description: """
This collection focuses on everyday tools for easing anxious thoughts. Each section offers short practices, breathing exercises, and journal prompts that can be done in just a few minutes.

The tone stays gentle and practical, making it a good companion for busy days, late-night overthinking, and anyone who wants realistic steps instead of long lectures.
""",
      ),
    ],
    'Classics': [
      Book(
        id: 'cl1',
        title: 'The Picture of Dorian Gray',
        author: 'Oscar Wilde',
        category: 'Classics',
        price: 25.00,
        imagePath: 'assets/images/book3.png',
        rating: 4.11,
        description: """
Dorian Gray is a charming young man whose portrait ages and decays while he stays outwardly perfect. As he chases pleasure and ignores consequences, the painting records every choice he would rather forget.

Wilde mixes gothic atmosphere with sharp social commentary, creating a classic that still feels unsettling and surprisingly modern.
""",
      ),
      Book(
        id: 'cl2',
        title: 'The Catcher in the Rye',
        author: 'J.D. Salinger',
        category: 'Classics',
        price: 30.00,
        imagePath: 'assets/images/book4.png',
        rating: 3.9,
        description: """
Holden Caulfield wanders New York City over a few restless days, skipping school and putting off going home. He searches for honesty in a world he keeps calling “phony”, yet reveals more about his own hurt than he admits.

The novel explores grief, loneliness, and the awkward space between teenager and adult, using a voice that still feels distinct decades later.
""",
      ),
    ],
    'Fantasy': [
      Book(
        id: 'fa1',
        title: 'Zodiac Academy',
        author: 'Caroline Peckham',
        category: 'Fantasy',
        price: 29.00,
        imagePath: 'assets/images/book4.png',
        rating: 4.4,
        description: """
At Zodiac Academy, star signs decide your power and your place. Two sisters arrive and discover they are heirs to a throne that many powerful students would rather keep for themselves.

Expect cutthroat classes, elemental magic, and rivalries that blur into complicated attraction.
""",
      ),
      Book(
        id: 'fa2',
        title: 'Sorrow and Starlight',
        author: 'Caroline Peckham, Susanne Valenti',
        category: 'Fantasy',
        price: 30.00,
        imagePath: 'assets/images/book6.png',
        rating: 4.5,
        description: """
This installment pulls together years of prophecy, found family, and slow-burn tension. War finally catches up with the characters, and every choice feels like it could cost a kingdom or a relationship.

It is a strong pick if you enjoy sweeping series with big battles, high emotion, and characters who are allowed to be messy and brave at the same time.
""",
      ),
      Book(
        id: 'fa3',
        title: 'Queen of Myth and Monsters',
        author: 'Scarlett St. Clair',
        category: 'Fantasy',
        price: 28.00,
        imagePath: 'assets/images/book7.png',
        rating: 4.2,
        description: """
A queen bound to ancient magic must face gods, monsters, and a marriage that blurs friend and foe. Court politics, forbidden power, and intense romance twist together as she tries to protect the people who depend on her.

Readers who like myth-inspired worlds and powerful, morally complex leads will feel right at home.
""",
      ),
    ],
    'Young Adult': [
      Book(
        id: 'ya1',
        title: 'Nine Liars',
        author: 'Maureen Johnson',
        category: 'Young adult',
        price: 16.00,
        imagePath: 'assets/images/book5.png',
        rating: 4.0,
        description: """
Years ago, a college friend group called themselves the Nine. Two members died at a party in the woods, and the survivors have been repeating the same story ever since.

Teen detective Stevie Bell visits England and starts asking the questions no one wants to answer. Old secrets, messy friendships, and a properly twisty mystery follow.
""",
      ),
      Book(
        id: 'ya2',
        title: 'Sunsets with Annie',
        author: 'Mindset',
        category: 'Young adult',
        price: 33.00,
        imagePath: 'assets/images/book5.png',
        rating: 4.2,
        description: """
Annie’s life runs on quiet routines until a sunset photography project pushes her to meet new people and try small, brave things. Each session brings the group a little closer and forces Annie to face what she really wants.

It is a cozy, reflective story about friendship, gentle romance, and choosing joy on ordinary days.
""",
      ),
    ],
    'Crime': [
      Book(
        id: 'cr1',
        title: 'Nine Liars',
        author: 'Maureen Johnson',
        category: 'Crime',
        price: 20.00,
        imagePath: 'assets/images/book3.png',
        rating: 4.0,
        description: """
Labelled as an accident, the deaths at a country house party never sat quite right. Every surviving friend remembers the night differently, and small contradictions keep slipping through.

The book blends cold-case investigation with modern campus life, giving crime readers plenty of suspects and motives to juggle.
""",
      ),
    ],
    'Horror': [
      Book(
        id: 'ho1',
        title: 'Dark Corners',
        author: 'E. L. Marrow',
        category: 'Horror',
        price: 18.00,
        imagePath: 'assets/images/book3.png',
        rating: 4.1,
        description: """
An old boarding house promises cheap rent and a fresh start, but the rooms do not stay quiet at night. Strange symbols, whispered conversations behind thin walls, and gaps in the building’s history hint at something watching the tenants.

This is for readers who like slow-building dread, creaking floors, and hauntings that feel psychological as well as supernatural.
""",
      ),
    ],
    'Sci-fi': [
      Book(
        id: 'sf1',
        title: 'Stars Beyond Atlas',
        author: 'J. K. Rowan',
        category: 'Sci-fi',
        price: 24.00,
        imagePath: 'assets/images/book7.png',
        rating: 4.0,
        description: """
A small exploration crew jumps to the edge of mapped space and finds a station that should not exist. The AI running it claims to know each of them already and offers everything humanity has ever wanted.

As systems glitch and loyalties fracture, the crew must decide what parts of their past they are willing to trade for a promised future.
""",
      ),
    ],
    'Drama': [
      Book(
        id: 'dr1',
        title: 'Stage Lights',
        author: 'Amelia Cross',
        category: 'Drama',
        price: 21.00,
        imagePath: 'assets/images/book5.png',
        rating: 4.1,
        description: """
A struggling city theatre pins its hopes on one last production. The story follows actors, crew, and the exhausted director as they juggle day jobs, family drama, and the risk of losing their beloved stage.

Backstage friendships, quiet rivalries, and opening night nerves make this a warm, character-focused read.
""",
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchRow(context),
              const SizedBox(height: 24),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: _categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.35, // slightly taller boxes
                  ),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return GestureDetector(
                      onTap: () {
                        final books =
                            _booksByCategory[category.name] ?? const <Book>[];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryBooksScreen(
                              categoryName: category.name,
                              books: books,
                            ),
                          ),
                        );
                      },
                      child: _CategoryCard(item: category),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------ SEARCH + FILTER ROW ------------

  Widget _buildSearchRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 22,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Search title/author/ISBN no',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _openFilterSheet(context),
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.filter_list,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  // ------------ FILTER BOTTOM SHEET ------------

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        double sliderValue = 40;

        return StatefulBuilder(
          builder: (context, setState) {
            final screenHeight = MediaQuery.of(context).size.height;

            return Container(
              height: screenHeight * 0.48, // a bit taller for comfortable text
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            sliderValue = 40;
                          });
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      _FilterChipButton(
                        label: 'Paper Back',
                        selected: true,
                      ),
                      const SizedBox(width: 12),
                      _FilterChipButton(
                        label: 'Hardcover',
                        selected: false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$0',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '0–80\$',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    min: 0,
                    max: 80,
                    value: sliderValue,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey[300],
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ------------ CATEGORY ITEM MODEL ------------

class _CategoryItem {
  final String name;
  final String imagePath;

  const _CategoryItem({
    required this.name,
    required this.imagePath,
  });
}

// ------------ CATEGORY CARD WIDGET ------------

class _CategoryCard extends StatelessWidget {
  final _CategoryItem item;

  const _CategoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        item.imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}

// ------------ FILTER CHIP BUTTON ------------

class _FilterChipButton extends StatelessWidget {
  final String label;
  final bool selected;

  const _FilterChipButton({
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: selected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ------------ CATEGORY BOOKS SCREEN ------------

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
          separatorBuilder: (_, _) => const SizedBox(height: 16),
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
