// lib/models/cart_item.dart
import 'book.dart';

class CartItem {
  final Book book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });

  double get total => book.priceValue * quantity;
}
