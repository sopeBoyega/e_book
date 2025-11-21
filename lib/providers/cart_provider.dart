// lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void add(Book book) {
    final index = _items.indexWhere((item) => item.book.id == book.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(book: book));
    }
    notifyListeners();
  }

  void remove(Book book) {
    _items.removeWhere((item) => item.book.id == book.id);
    notifyListeners();
  }

  void updateQuantity(Book book, int quantity) {
    final index = _items.indexWhere((item) => item.book.id == book.id);
    if (index == -1) return;

    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index].quantity = quantity;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.total);

  double get shipping {
    if (_items.isEmpty) return 0.0;
    // You can change this to a real shipping rule
    return 0.0;
  }

  double get total => subtotal + shipping;

  String get subtotalFormatted =>
      '\$${subtotal.toStringAsFixed(2)}';

  String get shippingFormatted =>
      shipping == 0.0 ? 'Free' : '\$${shipping.toStringAsFixed(2)}';

  String get totalFormatted =>
      '\$${total.toStringAsFixed(2)}';
}
