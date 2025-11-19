import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/review.dart';

class ReviewStorage {
  static const String _keyPrefix = 'book_reviews_';

  static Future<List<Review>> loadReviewsForBook(String bookId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString('$_keyPrefix$bookId');

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> rawList = json.decode(jsonString) as List<dynamic>;
      return rawList
          .map((item) => Review.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e, stack) {
      debugPrint('ReviewStorage.loadReviewsForBook error: $e');
      debugPrint(stack.toString());
      return [];
    }
  }

  static Future<void> saveReviewsForBook(
      String bookId,
      List<Review> reviews,
      ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> rawList =
      reviews.map((r) => r.toJson()).toList();
      final String jsonString = json.encode(rawList);
      await prefs.setString('$_keyPrefix$bookId', jsonString);
    } catch (e, stack) {
      debugPrint('ReviewStorage.saveReviewsForBook error: $e');
      debugPrint(stack.toString());
      // If it fails, we do nothing. In-memory list still works.
    }
  }
}
