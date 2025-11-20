import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderService = OrderService();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          backgroundColor: Colors.black,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrdersList(statusFilter: 'pending', orderService: orderService),
            OrdersList(statusFilter: 'completed', orderService: orderService),
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  final String statusFilter;
  final OrderService orderService;

  const OrdersList({
    required this.statusFilter,
    required this.orderService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrderModel>>(
      stream: orderService.getUserOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No $statusFilter orders yet.'));
        }

        final filteredOrders = snapshot.data!
            .where((order) => order.status.toLowerCase() == statusFilter)
            .toList();

        if (filteredOrders.isEmpty) {
          return Center(child: Text('No $statusFilter orders yet.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredOrders.length,
          itemBuilder: (context, index) {
            final order = filteredOrders[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(order.bookName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('Status: ${order.status}'),
                    const SizedBox(height: 2),
                    Text(
                        'Date: ${order.date.day}/${order.date.month}/${order.date.year}'),
                  ],
                ),
                trailing: Icon(
                  statusFilter == 'completed'
                      ? Icons.check_circle
                      : Icons.pending_actions,
                  color: statusFilter == 'completed'
                      ? Colors.green
                      : Colors.orange,
                ),
                onTap: () {
                  // Optional: Navigate to Order Details page
                },
              ),
            );
          },
        );
      },
    );
  }
}
