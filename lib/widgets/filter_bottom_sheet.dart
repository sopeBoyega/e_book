import 'package:flutter/material.dart';
import '../data/category_data.dart';

class BookFilter {
  final String? category;
  final String? author;
  final double? maxPrice;

  const BookFilter({
    this.category,
    this.author,
    this.maxPrice,
  });

  bool get isEmpty =>
      (category == null || category!.isEmpty) &&
          (author == null || author!.isEmpty) &&
          maxPrice == null;
}

class FilterBottomSheet extends StatefulWidget {
  final BookFilter? initialFilter;

  const FilterBottomSheet({super.key, this.initialFilter});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double _sliderValue;
  String? _selectedCategory;
  String? _selectedAuthor;

  late final List<String> _categoryNames;
  late final List<String> _authors;

  @override
  void initState() {
    super.initState();

    final initial = widget.initialFilter;

    _sliderValue = initial?.maxPrice ?? 80;
    _selectedCategory = initial?.category;
    _selectedAuthor = initial?.author;

    _categoryNames =
        CategoryData.categories.map((c) => c.name).toList(growable: false);

    final authorSet = <String>{};
    for (final list in CategoryData.booksByCategory.values) {
      for (final book in list) {
        final a = book.author.trim();
        if (a.isNotEmpty) authorSet.add(a);
      }
    }
    _authors = authorSet.toList()..sort();
  }

  void _resetFilters() {
    setState(() {
      _sliderValue = 80;
      _selectedCategory = null;
      _selectedAuthor = null;
    });
  }

  void _applyFilters() {
    final filter = BookFilter(
      category: _selectedCategory,
      author: _selectedAuthor,
      maxPrice: _sliderValue == 80 ? null : _sliderValue,
    );
    Navigator.pop(context, filter);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.6,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
              const Text(
                'Filter books',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: _resetFilters,
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category section
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('All'),
                        selected: _selectedCategory == null,
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = null;
                          });
                        },
                      ),
                      ..._categoryNames.map(
                            (name) => ChoiceChip(
                          label: Text(name),
                          selected: _selectedCategory == name,
                          onSelected: (_) {
                            setState(() {
                              _selectedCategory = name;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Author section
                  const Text(
                    'Author',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButton<String?>(
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      value: _selectedAuthor,
                      hint: const Text('Any author'),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('Any author'),
                        ),
                        ..._authors.map(
                              (author) => DropdownMenuItem<String?>(
                            value: author,
                            child: Text(author),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedAuthor = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Price section
                  const Text(
                    'Price range',
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
                        _sliderValue >= 80
                            ? 'Any price'
                            : 'Up to \$${_sliderValue.toStringAsFixed(0)}',
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
                    value: _sliderValue,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey[300],
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _applyFilters,
              child: const Text('Apply filters'),
            ),
          ),
        ],
      ),
    );
  }
}
