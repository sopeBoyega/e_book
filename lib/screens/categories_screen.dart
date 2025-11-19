import 'package:flutter/material.dart';
import '../data/category_data.dart';
import '../models/book.dart';
import '../widgets/category_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import 'category_books_screen.dart';
import 'book_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  BookFilter? _activeFilter;

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

  List<Book> get _filteredBooks {
    final query = _searchQuery.toLowerCase();
    final hasQuery = query.isNotEmpty;

    final allBooks = CategoryData.booksByCategory.values
        .expand((list) => list)
        .toList();

    return allBooks.where((book) {
      // text search
      if (hasQuery) {
        final titleMatch = book.title.toLowerCase().contains(query);
        final authorMatch = book.author.toLowerCase().contains(query);
        final categoryMatch = book.category.toLowerCase().contains(query);
        final idMatch = book.id.toLowerCase().contains(query);

        if (!(titleMatch || authorMatch || categoryMatch || idMatch)) {
          return false;
        }
      }

      // structured filters
      final filter = _activeFilter;
      if (filter != null && !filter.isEmpty) {
        if (filter.category != null && filter.category!.isNotEmpty) {
          if (book.category.toLowerCase() !=
              filter.category!.toLowerCase()) {
            return false;
          }
        }

        if (filter.author != null && filter.author!.isNotEmpty) {
          if (!book.author
              .toLowerCase()
              .contains(filter.author!.toLowerCase())) {
            return false;
          }
        }

        if (filter.maxPrice != null) {
          final price = double.tryParse(book.price) ?? double.infinity;
          if (price > filter.maxPrice!) {
            return false;
          }
        }
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = CategoryData.categories;
    final hasActiveFilter =
        _activeFilter != null && !_activeFilter!.isEmpty;
    final isSearching = _searchQuery.isNotEmpty || hasActiveFilter;
    final results = isSearching ? _filteredBooks : <Book>[];

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
              Text(
                isSearching ? 'Results' : 'Categories',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: isSearching
                    ? _buildSearchResults(results)
                    : _buildCategoryGrid(categories),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------ CATEGORY GRID ------------

  Widget _buildCategoryGrid(List<CategoryItem> categories) {
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        final List<Book> books =
            CategoryData.booksByCategory[category.name] ?? const <Book>[];

        return GestureDetector(
          onTap: () {
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
          child: CategoryCard(item: category),
        );
      },
    );
  }

  // ------------ SEARCH RESULTS LIST ------------

  Widget _buildSearchResults(List<Book> books) {
    if (books.isEmpty) {
      return Center(
        child: Text(
          'No books found for "$_searchQuery".',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      itemCount: books.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
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
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                book.imagePath,
                fit: BoxFit.cover,
                width: 48,
                height: 72,
              ),
            ),
            title: Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              book.author.isNotEmpty ? book.author : 'Unknown author',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${book.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text(
                      book.rating.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search title/author/ISBN no',
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                    },
                    child: Icon(
                      Icons.clear,
                      size: 18,
                      color: Colors.grey[600],
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

  Future<void> _openFilterSheet(BuildContext context) async {
    final result = await showModalBottomSheet<BookFilter>(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FilterBottomSheet(
        initialFilter: _activeFilter,
      ),
    );

    if (result != null) {
      setState(() {
        _activeFilter = result.isEmpty ? null : result;
      });
    }
  }
}
