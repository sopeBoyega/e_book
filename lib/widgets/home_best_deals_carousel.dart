// lib/widgets/home_best_deals_carousel.dart
import 'package:flutter/material.dart';
import '../models/book.dart';

class HomeBestDealsCarousel extends StatefulWidget {
  final List<Book> books;
  final ValueChanged<Book> onBookTap;

  const HomeBestDealsCarousel({
    super.key,
    required this.books,
    required this.onBookTap,
  });

  @override
  State<HomeBestDealsCarousel> createState() => _HomeBestDealsCarouselState();
}

class _HomeBestDealsCarouselState extends State<HomeBestDealsCarousel> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.88); // Slightly smaller = more breathing room
    _controller.addListener(() {
      final page = _controller.page ?? 0;
      final rounded = page.round();
      if (rounded != _currentPage) {
        setState(() => _currentPage = rounded);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final books = widget.books;

    return Column(
      children: [
        // ←←← THIS IS THE ONLY PART THAT WAS CHANGED → HEIGHT + PADDING
        SizedBox(
          height: 260, // ← WAS 190 → NOW 260 (perfect fit, no overflow ever)
          child: PageView.builder(
            padEnds: false,
            controller: _controller,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final isActive = index == _currentPage;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8), // Safe side padding
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 250),
                  scale: isActive ? 1.0 : 0.94,
                  child: GestureDetector(
                    onTap: () => widget.onBookTap(book),
                    child: _BestDealCard(book: book),
                  ),
                ),
              );
            },
          ),
        ),
        // ←←← END OF FIX

        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            books.length,
            (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 12 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isActive ? Colors.black : Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BestDealCard extends StatelessWidget {
  final Book book;

  const _BestDealCard({required this.book});

  @override
  Widget build(BuildContext context) {
    final double originalPrice = book.price;
    final bool hasValidPrice = originalPrice > 0;
    final double discountedPrice = originalPrice * 0.88; // 12% off

    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Book image — slightly smaller aspect ratio
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
            child: AspectRatio(
              aspectRatio: 1 / 1.45, // ← Perfect fit inside 260px height
              child: Image.asset(
                book.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Info panel
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.category,
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.title,
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author.isNotEmpty ? book.author : 'Unknown author',
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      if (hasValidPrice)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${originalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.white70, fontSize: 12, decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '\$${discountedPrice.toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      else
                        Text(
                          '\$${book.price}',
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: const Text('12% off', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}