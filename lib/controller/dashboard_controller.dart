import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

class AdminDashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var categories = <CategoryModel>[].obs;
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;

  /// Add Category
  Future<String?> addCategory(CategoryModel category) async {
    try {
      isLoading.value = true;
      final docRef = await _firestore.collection('categories').add(category.toMap());
      await docRef.update({'id': docRef.id});
      isLoading.value = false;
      return docRef.id;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to add category: $e");
      return null;
    }
  }

  Future<void> addProductToCategory(String categoryId, ProductModel product) async {
    try {
      final productRef = await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .add(product.toMap());
      await productRef.update({'id': productRef.id});
    } catch (e) {
      Get.snackbar("Error", "Failed to add product: $e");
    }
  }

  Future<void> updateCategoryProductCount(String categoryId, int count) async {
    try {
      await _firestore.collection('categories').doc(categoryId).update({
        'productsCount': FieldValue.increment(count),
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to update product count: $e");
    }
  }

  /// Add Product
  Future<void> addProduct(ProductModel product) async {
    try {
      isLoading(true);

      await _firestore.collection('products').add(product.toMap());

      final categoryRef = await _firestore
          .collection('categories')
          .where('title', isEqualTo: product.category)
          .get();

      if (categoryRef.docs.isNotEmpty) {
        final docId = categoryRef.docs.first.id;
        await _firestore.collection('categories').doc(docId).update({
          'productsCount': FieldValue.increment(1),
        });
      }

      Get.snackbar("Success", "Product added successfully!");
      await fetchProducts();
      await fetchCategories();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Fetch all categories
  Future<void> fetchCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      print("Fetched ${snapshot.docs.length} categories from Firestore");
      categories.value =
          snapshot.docs.map((doc) => CategoryModel.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  /// Fetch all products
  Future<void> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      products.value =
          snapshot.docs.map((doc) => ProductModel.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    final usersSnap = await _firestore.collection('userdata').get();
    final ordersSnap = await _firestore.collection('orders').get();

    double totalAmount = 0;
    for (var doc in ordersSnap.docs) {
      totalAmount += (doc['total'] ?? 0).toDouble();
    }

    return {
      "users": usersSnap.size,
      "orders": ordersSnap.size,
      "amount": totalAmount,
      "pending":
          ordersSnap.docs.where((e) => (e['status'] ?? '') == 'pending').length,
    };
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _firestore.collection('categories').doc(id).delete();
      categories.removeWhere((cat) => cat.id == id);
      print("Category deleted successfully: $id");
    } catch (e) {
      print("Error deleting category: $e");
    }
  }

  Future<void> updateCategory(String id, CategoryModel category) async {
    await _firestore.collection('categories').doc(id).update(category.toMap());
    fetchCategories();
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').doc(product.id).update(product.toMap());
      await fetchProducts();
    } catch (e) {
      print('Error updating product: $e');
      Get.snackbar('Error', 'Failed to update product');
    }
  }

  Future<void> deleteProduct(String id) async {
    await _firestore.collection('products').doc(id).delete();
    fetchProducts();
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }
}
