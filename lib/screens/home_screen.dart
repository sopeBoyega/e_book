import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import '../widgets/home_best_deals_carousel.dart';
import '../data/home_data.dart';
import 'book_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 0 = This Week, 1 = This Month, 2 = This Year
  int _selectedTopFilter = 0;

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
      color: const Color(0xFFF2F2F2),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),
                const SizedBox(height: 24),

                // Best Deals
                _buildSectionTitle('Best Deals'),
                const SizedBox(height: 12),
                HomeBestDealsCarousel(
                  books: HomeData.bestDeals,
                  onBookTap: _openBookDetails,
                ),
                const SizedBox(height: 32),

                // Top Books with filters
                _buildSectionTitle('Top Books'),
                const SizedBox(height: 12),
                _buildTopFilterChips(),
                const SizedBox(height: 12),
                _buildHorizontalBookList(_currentTopBooks),
                const SizedBox(height: 32),

                // Latest Books
                _buildSectionTitle('Latest Books'),
                const SizedBox(height: 12),
                _buildHorizontalBookList(HomeData.latestBooks),
                const SizedBox(height: 32),

                // Upcoming Books
                _buildSectionTitle('Upcoming Books'),
                const SizedBox(height: 12),
                _buildHorizontalBookList(HomeData.upcomingBooks),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- TOP BAR ----------------

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Happy Reading!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.search, size: 22),
        ),
      ],
    );
  }

  // ---------------- SECTION TITLE ----------------

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // ---------------- TOP FILTER CHIPS ----------------

  Widget _buildTopFilterChips() {
    return Row(
      children: [
        _buildFilterChip(
          label: 'This Week',
          selected: _selectedTopFilter == 0,
          onTap: () {
            setState(() => _selectedTopFilter = 0);
          },
        ),
        const SizedBox(width: 8),
        _buildFilterChip(
          label: 'This Month',
          selected: _selectedTopFilter == 1,
          onTap: () {
            setState(() => _selectedTopFilter = 1);
          },
        ),
        const SizedBox(width: 8),
        _buildFilterChip(
          label: 'This Year',
          selected: _selectedTopFilter == 2,
          onTap: () {
            setState(() => _selectedTopFilter = 2);
          },
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ---------------- HORIZONTAL BOOK LIST ----------------

  Widget _buildHorizontalBookList(List<Book> books) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () => _openBookDetails(book),
            child: BookCard(book: book),
          );
        },
      ),
    );
  }
}
