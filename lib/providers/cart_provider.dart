// lib/providers/cart_provider.dart
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import '../models/book.dart';

class CartItem {
  final Book book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });

  double get total => book.price * quantity;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.total);
  
  // $10 flat shipping (or free if cart empty)
  double get shipping => items.isEmpty ? 0.0 : 10.0;
  
  double get total => subtotal + shipping;

  // DOLLAR FORMATTING — THIS IS WHAT YOU WANTED
  String get subtotalFormatted => '\$${subtotal.toStringAsFixed(2)}';
  String get shippingFormatted => items.isEmpty ? 'FREE' : '\$10.00';
  String get totalFormatted => '\$${total.toStringAsFixed(2)}';

  void add(Book book) {
    final existing = _items.firstWhereOrNull((i) => i.book.id == book.id);
    if (existing != null) {
      existing.quantity++;
    } else {
      _items.add(CartItem(book: book));
    }
    notifyListeners();
  }

  void remove(Book book) {
    _items.removeWhere((i) => i.book.id == book.id);
    notifyListeners();
  }

  void decreaseQuantity(Book book) {
    final item = _items.firstWhereOrNull((i) => i.book.id == book.id);
    if (item != null) {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        remove(book);
      }
      notifyListeners();
    }
  }

  void updateQuantity(Book book, int quantity) {
    if (quantity <= 0) {
      remove(book);
      return;
    }
    final item = _items.firstWhereOrNull((i) => i.book.id == book.id);
    if (item != null) {
      item.quantity = quantity;
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}