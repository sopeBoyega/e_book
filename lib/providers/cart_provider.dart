
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import '../models/book.dart';

class CartItem {
  final Book book;
  int quantity;
  CartItem({required this.book, this.quantity = 1});
  double get total => book.price * quantity; 
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, i) => sum + i.quantity);
  double get subtotal => _items.fold(0, (sum, i) => sum + i.total);
  double get shipping => items.isEmpty ? 0.0 : 10.0;
  double get total => subtotal + shipping;

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

  void updateQuantity(Book book, int qty) {
    if (qty <= 0) {
      remove(book);
      return;
    }
    final item = _items.firstWhere((i) => i.book.id == book.id);
    item.quantity = qty;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}