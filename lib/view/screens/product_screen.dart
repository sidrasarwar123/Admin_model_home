import 'package:admin_model_home/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_color.dart';
import '../../constant/app_image.dart';
import '../../models/product_model.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfeild.dart';
import '../../widgets/product_row.dart';
import '../../widgets/top_bar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final AdminDashboardController productController = Get.put(AdminDashboardController());
  bool showUpdateProduct = false;
  ProductModel? editingProduct; 

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void _showAddProduct() {
    setState(() {
      editingProduct = null; 
      productNameController.clear();
      descriptionController.clear();
      priceController.clear();
      showUpdateProduct = true;
    });
  }

  void _showEditProduct(ProductModel product) {
    setState(() {
      editingProduct = product; 
      productNameController.text = product.title;
      descriptionController.text = product.description;
      priceController.text = product.price.toString();
      showUpdateProduct = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Topbar(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Show All Products",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.buttoncolor,
                  ),
                ),
                // ElevatedButton(
                //   onPressed: _showAddProduct,
                //   style: ElevatedButton.styleFrom(backgroundColor: AppColor.buttoncolor),
                //   child: const Text("Add Product"),
                // )
              ],
            ),
            const SizedBox(height: 20),

            if (showUpdateProduct)
              Expanded(
                child: Center(
                  child: Container(
                    width: 600,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColor.textcolor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              editingProduct == null ? "Add Product" : "Edit Product",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.buttoncolor,
                              ),
                            ),
                          
                            if (editingProduct != null)
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(editingProduct!.image),
                              ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Product Name",
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                    hintText: "Name",
                                    controller: productNameController,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Description",
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                    hintText: "Description",
                                    controller: descriptionController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Price *",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 300, top: 15),
                          child: CustomTextField(
                            hintText: "Price",
                            controller: priceController,
                          ),
                        ),
                        const SizedBox(height: 60),

                        CustomButton(
                          text: editingProduct == null ? "Add Product" : "Update Product",
                          onPressed: () async {
                            if (productNameController.text.isEmpty ||
                                priceController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please fill all required fields")),
                              );
                              return;
                            }

                            if (editingProduct == null) {
                           
                              final newProduct = ProductModel(
                                id: '',
                                title: productNameController.text,
                                category: "General",
                                price: double.tryParse(priceController.text) ?? 0,
                                description: descriptionController.text,
                                colors: [],
                                image: AppImage.image,
                              );
                              await productController.addProduct(newProduct);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Product Added Successfully!")),
                              );
                            } else {
                            
                              final updatedProduct = ProductModel(
                                id: editingProduct!.id,
                                title: productNameController.text,
                                category: editingProduct!.category,
                                price: double.tryParse(priceController.text) ?? 0,
                                description: descriptionController.text,
                                colors: editingProduct!.colors,
                                image: editingProduct!.image, // keep same image
                              );
                              await productController.updateProduct(updatedProduct);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Product Updated Successfully!")),
                              );
                            }

                            setState(() {
                              showUpdateProduct = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else ...[
              Container(
                decoration: BoxDecoration(
                  color: AppColor.textcolor,
                  border: Border.all(color: AppColor.textDark),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text("Product Image",
                          style: TextStyle(color: AppColor.buttoncolor, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 20),
                    Text("Name",
                        style: TextStyle(color: AppColor.buttoncolor, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 90),
                    Text("Price",
                        style: TextStyle(color: AppColor.buttoncolor, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 80),
                    Text("Description",
                        style: TextStyle(color: AppColor.buttoncolor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  final products = productController.products;
                  if (products.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductRow(
                        product: product,
                        onEdit: () => _showEditProduct(product),
                        onDelete: () async {
                          await productController.deleteProduct(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Deleted ${product.title} successfully")),
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
