import 'package:flutter/material.dart';

class HomeSearchField extends StatelessWidget {
  final TextEditingController controller;
  final bool hasQuery;
  final VoidCallback onClear;

  const HomeSearchField({
    super.key,
    required this.controller,
    required this.hasQuery,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search title/author/ISBN no',
                border: InputBorder.none,
                isCollapsed: true,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          if (hasQuery)
            GestureDetector(
              onTap: onClear,
              child: Icon(
                Icons.clear,
                size: 18,
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
    );
  }
}
