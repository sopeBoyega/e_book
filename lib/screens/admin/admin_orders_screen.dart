import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminOrdersScreen extends StatelessWidget {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Orders')),
      body: StreamBuilder<QuerySnapshot>(
        // FIX 1: Changed 'orderedAt' to 'date' to match your Firestore field name.
        stream: orders.orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('No orders yet.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final order = docs[index];
              final data = order.data() as Map<String, dynamic>;

              // -----------------------------------------------------------------
              // FIX 2: Removed the faulty access to 'items[0]'
              // and accessed fields directly using null-aware operators (??).
              // -----------------------------------------------------------------
              
              // We assume 'bookName', 'price', and 'thumbnail' are top-level fields
              // since 'items' was missing/null in your previous screenshot.
              final title = data['bookName'] ?? 'Unknown Item (Book Name Missing)';
              
              // Added safety checks for thumb and price, assuming they are direct fields.
              final thumb = data['thumbnail'] ?? '';
              final price = data['price'] ?? 0.0; 

              final status = data['status'] ?? 'pending';
              // FIX 3: Using the correct field 'date' instead of 'orderedAt'
              final orderedAt = data['date']; 
              final userId = data['userId'] ?? 'unknown';

              // If the original 'items' field was supposed to be present, 
              // we can check if it's there and use a fallback for safety.
              // final item = (data['items'] is List && data['items'].isNotEmpty) 
              //     ? data['items'][0] 
              //     : null;
              // final title = item?['title'] ?? data['bookName'] ?? 'Unknown Item';
              // final thumb = item?['thumbnail'] ?? data['thumbnail'] ?? '';
              // final price = item?['price'] ?? data['price'] ?? 0.0; 
              // -----------------------------------------------------------------


              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          thumb,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(
                                height: 60,
                                width: 60,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image_not_supported),
                              ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Info column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Buyer: $userId",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              // Using the data retrieved from the correct field
                              "Date: ${_formatDate(orderedAt)}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "₦$price",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Status dropdown
                      DropdownButton<String>(
                        value: status,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                              value: 'pending', child: Text('Pending')),
                          DropdownMenuItem(
                              value: 'processing', child: Text('Processing')),
                          DropdownMenuItem(
                              value: 'completed', child: Text('Completed')),
                          DropdownMenuItem(
                              value: 'cancelled', child: Text('Cancelled')),
                        ],
                        onChanged: (value) async {
                          if (value == null) return;
                          await orders.doc(order.id).update({'status': value});
                          // Using a more console-friendly approach than a snackbar
                          // in this context to avoid potential iframe issues.
                          print('Order ${order.id} updated to $value'); 
                          // If running on a real device, the SnackBar logic is fine.
                          /*
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Order updated to $value'),
                            ),
                          );
                          */
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

String _formatDate(dynamic raw) {
  try {
    if (raw == null) return '';
    // The date field in your console screenshot is stored as a string,
    // but the following logic handles it if it were a proper Firestore Timestamp.
    if (raw is Timestamp) {
      final date = raw.toDate();
      return "${date.day}/${date.month}/${date.year}";
    }
    // If it's a string (like in your console screenshot), return it as is.
    return raw.toString();
  } catch (e) {
    // Fallback for any other type of error
    return raw.toString();
  }
}