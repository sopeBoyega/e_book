import 'package:flutter/material.dart';

class HomeTopFilterChips extends StatelessWidget {
  final int selectedFilter;
  final ValueChanged<int> onFilterChanged;

  const HomeTopFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterChip(
          label: 'This Week',
          selected: selectedFilter == 0,
          onTap: () => onFilterChanged(0),
        ),
        const SizedBox(width: 8),
        _FilterChip(
          label: 'This Month',
          selected: selectedFilter == 1,
          onTap: () => onFilterChanged(1),
        ),
        const SizedBox(width: 8),
        _FilterChip(
          label: 'This Year',
          selected: selectedFilter == 2,
          onTap: () => onFilterChanged(2),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
}
