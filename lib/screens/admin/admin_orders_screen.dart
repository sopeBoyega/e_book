import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminOrdersScreen extends StatelessWidget {
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Orders')),
      body: StreamBuilder<QuerySnapshot>(
        stream: orders.orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('No orders yet.'));

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final order = docs[index];
              final bookName = order['bookName'] ?? 'Unknown';
              final userName = order['userName'] ?? 'Unknown';
              final status = order['status'] ?? 'pending';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  title: Text(bookName),
                  subtitle: Text('Buyer: $userName\nDate: ${_formatDate(order['date'])}'),
                  isThreeLine: true,
                  trailing: DropdownButton<String>(
                    value: status,
                    items: const [
                      DropdownMenuItem(value: 'pending', child: Text('Pending')),
                      DropdownMenuItem(value: 'processing', child: Text('Processing')),
                      DropdownMenuItem(value: 'completed', child: Text('Completed')),
                      DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
                    ],
                    onChanged: (value) async {
                      if (value == null) return;
                      await orders.doc(order.id).update({'status': value});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order updated to $value')));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(dynamic raw) {
    try {
      if (raw == null) return '';
      if (raw is int) return DateTime.fromMillisecondsSinceEpoch(raw).toLocal().toString().split('.')[0];
      return raw.toString();
    } catch (e) {
      return raw.toString();
    }
  }
}
