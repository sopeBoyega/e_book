import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';
import '../widgets/home_best_deals_carousel.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/home_search_field.dart';
import '../widgets/home_top_filter_chips.dart';
import '../widgets/horizontal_book_list.dart';
import '../widgets/search_results_list.dart';
import '../widgets/section_title.dart';
import 'book_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 0 = This Week, 1 = This Month, 2 = This Year
  int _selectedTopFilter = 0;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // ---------- HELPERS USING A GIVEN LIST OF BOOKS ----------

  List<Book> _bestDeals(List<Book> books) =>
      books.where((b) => b.id.toLowerCase().startsWith('deal')).toList();

  List<Book> _latestBooks(List<Book> books) =>
      books.where((b) => b.id.toLowerCase().startsWith('latest')).toList();

  List<Book> _upcomingBooks(List<Book> books) =>
      books.where((b) => b.id.toLowerCase().startsWith('upcoming')).toList();

  List<Book> _topBooksThisWeek(List<Book> books) =>
      books.where((b) => b.id.toLowerCase().startsWith('top')).toList();

  List<Book> _topBooksThisMonth(List<Book> books) =>
      books.where((b) => b.id.toLowerCase().startsWith('tm')).toList();

  List<Book> _topBooksThisYear(List<Book> books) =>
      books.where((b) => b.id.toLowerCase().startsWith('ty')).toList();

  List<Book> _currentTopBooks(List<Book> books) {
    switch (_selectedTopFilter) {
      case 1:
        return _topBooksThisMonth(books);
      case 2:
        return _topBooksThisYear(books);
      default:
        return _topBooksThisWeek(books);
    }
  }

  List<Book> _searchResults(List<Book> allBooks) {
    if (_searchQuery.isEmpty) return [];

    final query = _searchQuery.toLowerCase();

    return allBooks.where((book) {
      final titleMatch = book.title.toLowerCase().contains(query);
      final authorMatch = book.author.toLowerCase().contains(query);
      final categoryMatch = book.category.toLowerCase().contains(query);
      final idMatch = book.id.toLowerCase().contains(query); // ISBN

      return titleMatch || authorMatch || categoryMatch || idMatch;
    }).toList();
  }

  void _openBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookDetailScreen(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F2), // background for the whole home tab
      child: SafeArea(
        bottom: false,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Firestore error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final docs = snapshot.data?.docs ?? [];
            final allBooks = docs
                .map(
                  (doc) => Book.fromMap(
                doc.id,          // id first
                doc.data(),      // then data
              ),
            )
                .toList();

            debugPrint('HomeScreen: loaded ${allBooks.length} books');

            final bool isSearching = _searchQuery.isNotEmpty;
            final results = _searchResults(allBooks);

            final bestDeals = _bestDeals(allBooks);
            final currentTop = _currentTopBooks(allBooks);
            final latest = _latestBooks(allBooks);
            final upcoming = _upcomingBooks(allBooks);

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeTopBar(),
                  const SizedBox(height: 16),
                  HomeSearchField(
                    controller: _searchController,
                    hasQuery: _searchQuery.isNotEmpty,
                    onClear: () => _searchController.clear(),
                  ),
                  const SizedBox(height: 24),

                  if (isSearching) ...[
                    const SectionTitle(title: 'Search results'),
                    const SizedBox(height: 12),
                    SearchResultsList(
                      books: results,
                      searchQuery: _searchQuery,
                      onBookTap: _openBookDetails,
                    ),
                  ] else ...[
                    const SectionTitle(title: 'Best Deals'),
                    const SizedBox(height: 12),
                    HomeBestDealsCarousel(
                      books: bestDeals,
                      onBookTap: _openBookDetails,
                    ),
                    const SizedBox(height: 32),

                    const SectionTitle(title: 'Top Books'),
                    const SizedBox(height: 12),
                    HomeTopFilterChips(
                      selectedFilter: _selectedTopFilter,
                      onFilterChanged: (value) {
                        setState(() => _selectedTopFilter = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    HorizontalBookList(
                      books: currentTop,
                      onBookTap: _openBookDetails,
                    ),
                    const SizedBox(height: 32),

                    const SectionTitle(title: 'Latest Books'),
                    const SizedBox(height: 12),
                    HorizontalBookList(
                      books: latest,
                      onBookTap: _openBookDetails,
                    ),
                    const SizedBox(height: 32),

                    const SectionTitle(title: 'Upcoming Books'),
                    const SizedBox(height: 12),
                    HorizontalBookList(
                      books: upcoming,
                      onBookTap: _openBookDetails,
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
