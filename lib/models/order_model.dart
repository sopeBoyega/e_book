class OrderModel {
  final String id;
  final String bookName;
  final String userName;
  final String status;
  final DateTime date;

  OrderModel({
    required this.id,
    required this.bookName,
    required this.userName,
    required this.status,
    required this.date,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> map) {
    return OrderModel(
      id: id,
      bookName: map['bookName'] ?? '',
      userName: map['userName'] ?? '',
      status: map['status'] ?? 'pending',
      date: (map['date'] is int) ? DateTime.fromMillisecondsSinceEpoch(map['date']) : DateTime.tryParse(map['date']?.toString() ?? '') ?? DateTime.now(),
    );
  }
}
