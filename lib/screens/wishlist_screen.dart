import 'dart:io';
import 'package:flutter/material.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WishList")),
      body: const Center(
        child: Text("No Items here yet"),
      ),
    );
  }
}
