import 'package:flutter/foundation.dart';

class Review {
  final String id;
  final String userName;
  int rating; // 1–5
  String text;
  int likes;

  Review({
    required this.id,
    required this.userName,
    required this.rating,
    required this.text,
    this.likes = 0,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      userName: json['userName'] as String,
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      likes: (json['likes'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'rating': rating,
      'text': text,
      'likes': likes,
    };
  }

  Review copyWith({
    String? id,
    String? userName,
    int? rating,
    String? text,
    int? likes,
  }) {
    return Review(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      rating: rating ?? this.rating,
      text: text ?? this.text,
      likes: likes ?? this.likes,
    );
  }
}
