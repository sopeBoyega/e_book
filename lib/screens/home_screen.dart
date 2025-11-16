import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Replace with real data later
  final List<String> _covers = const [
    'https://picsum.photos/seed/book1/300/450',
    'https://picsum.photos/seed/book2/300/450',
    'https://picsum.photos/seed/book3/300/450',
    'https://picsum.photos/seed/book4/300/450',
    'https://picsum.photos/seed/book5/300/450',
    'https://picsum.photos/seed/book6/300/450',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Bookstore',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.65,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _covers.length,
          itemBuilder:
              (_, i) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(_covers[i], fit: BoxFit.cover),
              ),
        ),
      ),
    );
  }
}
