import 'package:flutter/material.dart';
import '../data/home_data.dart';
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

  // -------- SEARCH STATE --------
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

  // -------- DATA HELPERS --------

  List<Book> get _currentTopBooks {
    switch (_selectedTopFilter) {
      case 1:
        return HomeData.topBooksThisMonth;
      case 2:
        return HomeData.topBooksThisYear;
      default:
        return HomeData.topBooksThisWeek;
    }
  }

  // Combine all books on the home screen into one list for searching
  List<Book> get _allBooks {
    final Map<String, Book> map = {};

    void addList(List<Book> list) {
      for (final book in list) {
        map[book.id] = book;
      }
    }

    addList(HomeData.bestDeals);
    addList(HomeData.topBooksThisWeek);
    addList(HomeData.topBooksThisMonth);
    addList(HomeData.topBooksThisYear);
    addList(HomeData.latestBooks);
    addList(HomeData.upcomingBooks);

    return map.values.toList();
  }

  List<Book> get _searchResults {
    if (_searchQuery.isEmpty) return [];

    final query = _searchQuery.toLowerCase();
    final allBooks = _allBooks;

    return allBooks.where((book) {
      final titleMatch = book.title.toLowerCase().contains(query);
      final authorMatch = book.author.toLowerCase().contains(query);
      final categoryMatch = book.category.toLowerCase().contains(query);
      // Treat id as "ISBN no" for this demo
      final idMatch = book.id.toLowerCase().contains(query);

      return titleMatch || authorMatch || categoryMatch || idMatch;
    }).toList();
  }

  // -------- NAVIGATION --------

  void _openBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookDetailScreen(book: book),
      ),
    );
  }

  // -------- BUILD --------

  @override
  Widget build(BuildContext context) {
    final bool isSearching = _searchQuery.isNotEmpty;
    final results = _searchResults;

    return Container(
      color: const Color(0xFFF2F2F2),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  // Best Deals
                  const SectionTitle(title: 'Best Deals'),
                  const SizedBox(height: 12),
                  HomeBestDealsCarousel(
                    books: HomeData.bestDeals,
                    onBookTap: _openBookDetails,
                  ),
                  const SizedBox(height: 32),

                  // Top Books with filters
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
                    books: _currentTopBooks,
                    onBookTap: _openBookDetails,
                  ),
                  const SizedBox(height: 32),

                  // Latest Books
                  const SectionTitle(title: 'Latest Books'),
                  const SizedBox(height: 12),
                  HorizontalBookList(
                    books: HomeData.latestBooks,
                    onBookTap: _openBookDetails,
                  ),
                  const SizedBox(height: 32),

                  // Upcoming Books
                  const SectionTitle(title: 'Upcoming Books'),
                  const SizedBox(height: 12),
                  HorizontalBookList(
                    books: HomeData.upcomingBooks,
                    onBookTap: _openBookDetails,
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
