import 'package:flutter/material.dart';
import '../models/review.dart';
import '../data/review_storage.dart';

class BookReviewsSection extends StatefulWidget {
  final String bookId;
  final bool isLoggedIn;

  const BookReviewsSection({
    super.key,
    required this.bookId,
    this.isLoggedIn = true,
  });

  @override
  State<BookReviewsSection> createState() => _BookReviewsSectionState();
}

class _BookReviewsSectionState extends State<BookReviewsSection> {
  List<Review> _reviews = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    try {
      final items = await ReviewStorage.loadReviewsForBook(widget.bookId);
      if (!mounted) return;
      setState(() {
        _reviews = items;
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _saveReviews() async {
    await ReviewStorage.saveReviewsForBook(widget.bookId, _reviews);
  }

  void _handleSubmit({
    Review? existing,
    required int rating,
    required String text,
  }) {
    setState(() {
      if (existing != null) {
        existing.rating = rating;
        existing.text = text;
      } else {
        _reviews.insert(
          0,
          Review(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            userName: 'You',
            rating: rating,
            text: text,
            likes: 0,
          ),
        );
      }
    });
    _saveReviews();
  }

  void _handleLike(Review review) {
    setState(() {
      review.likes += 1;
    });
    _saveReviews();
  }

  void _openReviewSheet({Review? existing}) {
    if (!widget.isLoggedIn) return;

    final bool isEditing = existing != null;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return WriteReviewSheet(
          title: isEditing ? 'Edit review' : 'Write a review',
          initialRating: existing?.rating ?? 4,
          initialText: existing?.text ?? '',
          onSubmit: (rating, text) {
            _handleSubmit(existing: existing, rating: rating, text: text);
            Navigator.pop(ctx);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Reviews',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (widget.isLoggedIn)
              TextButton.icon(
                onPressed: () => _openReviewSheet(),
                icon: const Icon(Icons.rate_review, size: 18),
                label: const Text('Write a review'),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (_reviews.isEmpty)
          Text(
            widget.isLoggedIn
                ? 'No reviews yet. Be the first to write one.'
                : 'No reviews yet.',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          )
        else
          Column(
            children:
            _reviews.map((review) => _buildReviewCard(review)).toList(),
          ),
      ],
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + stars
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.userName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                      (index) {
                    final starIndex = index + 1;
                    return Icon(
                      starIndex <= review.rating
                          ? Icons.star
                          : Icons.star_border,
                      size: 16,
                      color: Colors.amber,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.text,
            style: const TextStyle(fontSize: 13, height: 1.3),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () => _handleLike(review),
                icon: const Icon(
                  Icons.thumb_up_alt_outlined,
                  size: 16,
                ),
                label: Text(
                  review.likes.toString(),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              if (widget.isLoggedIn && review.userName == 'You')
                TextButton(
                  onPressed: () => _openReviewSheet(existing: review),
                  child: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class WriteReviewSheet extends StatefulWidget {
  final String title;
  final int initialRating;
  final String initialText;
  final void Function(int rating, String text) onSubmit;

  const WriteReviewSheet({
    super.key,
    required this.title,
    required this.initialRating,
    required this.initialText,
    required this.onSubmit,
  });

  @override
  State<WriteReviewSheet> createState() => _WriteReviewSheetState();
}

class _WriteReviewSheetState extends State<WriteReviewSheet> {
  late int _rating;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty || _rating < 1) {
      return;
    }
    widget.onSubmit(_rating, text);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, bottomInset + 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 8),

            const Text(
              'Your rating',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                    (index) {
                  final starIndex = index + 1;
                  final isFilled = starIndex <= _rating;
                  return IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isFilled ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = starIndex;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              'Your review',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Share your thoughts about this book',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    widget.initialText.isEmpty ? 'Submit' : 'Save',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
