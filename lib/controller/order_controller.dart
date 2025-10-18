import 'package:admin_model_home/models/deliver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  var pendingOrders = <OrderModel>[].obs;
  var deliveredOrders = <OrderModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print(' OrderController initialized');
    listenOrders();
  }

  void listenOrders() {
    print('Listening for Firestore orders...');
    isLoading(true);

    _db.collection('orders').snapshots().listen((snapshot) {
      print(' Fetched ${snapshot.docs.length} orders from Firestore');

      if (snapshot.docs.isNotEmpty) {
        print(' First Firestore order doc: ${snapshot.docs.first.data()}');
      } else {
        print(' No orders found in Firestore!');
      }

      final allOrders = snapshot.docs.map((doc) {
        print('🛠 Converting Firestore doc → OrderModel (${doc.id})');
        return OrderModel.fromMap(doc.id, doc.data());
      }).toList();

      print(' Converted ${allOrders.length} orders into OrderModel');

      pendingOrders.value =
          allOrders.where((o) => o.status == 'pending').toList();
      deliveredOrders.value =
          allOrders.where((o) => o.status == 'delivered').toList();

      print(' Pending Orders: ${pendingOrders.length}');
      print(' Delivered Orders: ${deliveredOrders.length}');

      isLoading(false);
    }, onError: (e) {
      print(" Error fetching orders: $e");
      isLoading(false);
    });
  }

  Future<void> updateOrderStatus(String id, String status) async {
    try {
      print(' Updating order ($id) → status: $status');
      await _db.collection('orders').doc(id).update({'status': status});
      print(' Order ($id) updated successfully');
      Get.snackbar('Success', 'Order marked as $status');
    } catch (e) {
      print(' Failed to update order ($id): $e');
      Get.snackbar('Error', 'Failed to update: $e');
    }
  }

  Future<void> deleteOrder(String id) async {
    try {
      print(' Deleting order ($id)...');
      await _db.collection('orders').doc(id).delete();
      print(' Order ($id) deleted successfully');
      Get.snackbar('Deleted', 'Order removed successfully');
    } catch (e) {
      print(' Failed to delete order ($id): $e');
      Get.snackbar('Error', 'Failed to delete: $e');
    }
  }
}
