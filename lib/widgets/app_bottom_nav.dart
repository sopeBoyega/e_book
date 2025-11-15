import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F5FA), // light pink/grey background
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          _NavItem(
            icon: Icons.home_filled,
            label: 'Home',
            index: 0,
            currentIndex: currentIndex,
            onTap: onTabSelected,
          ),
          _NavItem(
            icon: Icons.category_outlined,
            label: 'Categories',
            index: 1,
            currentIndex: currentIndex,
            onTap: onTabSelected,
          ),
          _NavItem(
            icon: Icons.shopping_cart_outlined,
            label: 'Cart',
            index: 2,
            currentIndex: currentIndex,
            onTap: onTabSelected,
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'Account',
            index: 3,
            currentIndex: currentIndex,
            onTap: onTabSelected,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;
    final Color iconColor = isSelected ? Colors.black : Colors.grey;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.grey[300] : Colors.transparent,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
