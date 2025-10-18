class OrderModel {
  final String id;
  final String productName;
  final int qty;
  final String address;
  final String status;
  final double total;

  OrderModel({
    required this.id,
    required this.productName,
    required this.qty,
    required this.address,
    required this.status,
    required this.total,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> map) {
    print(' USING OrderModel from deliver_model.dart');
    print(' Firestore Order Data for $id: $map');

    final List<dynamic> orderItems = map['orderItems'] ?? [];

    String productName = '';
    int qty = 0;

    if (orderItems.isNotEmpty && orderItems.first is Map<String, dynamic>) {
      final firstItem = orderItems.first as Map<String, dynamic>;
      print('🛒 First Order Item: $firstItem');

      productName = firstItem['title']?.toString() ?? '';
      qty = int.tryParse(firstItem['qty']?.toString() ?? '0') ?? 0;
    } else {
      print(' orderItems is empty or invalid for order: $id');
    }

    print(' Parsed OrderModel → '
        'productName: $productName, qty: $qty, '
        'address: ${map['address']}, '
        'status: ${map['status']}, '
        'total: ${map['total']}');

    return OrderModel(
      id: id,
      productName: productName,
      qty: qty,
      address: map['address']?.toString() ?? '',
      status: map['status']?.toString() ?? 'pending',
      total: (map['total'] is num) ? (map['total'] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    final data = {
      'address': address,
      'status': status,
      'total': total,
      'orderItems': [
        {
          'title': productName,
          'qty': qty,
        }
      ],
    };

    print(' Converting OrderModel to Map: $data');
    return data;
  }
}
