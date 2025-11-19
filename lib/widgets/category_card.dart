import 'package:flutter/material.dart';
import '../data/category_data.dart';

class CategoryCard extends StatelessWidget {
  final CategoryItem item;

  const CategoryCard({super.key, required this.item});

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
