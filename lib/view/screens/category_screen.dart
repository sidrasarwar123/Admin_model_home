import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/constant/app_image.dart';
import 'package:admin_model_home/controller/dashboard_controller.dart';
import 'package:admin_model_home/models/category_model.dart';
import 'package:admin_model_home/widgets/category_row.dart';
import 'package:admin_model_home/widgets/custom_button.dart';
import 'package:admin_model_home/widgets/custom_textfeild.dart';
import 'package:admin_model_home/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool showAddCategory = false;
  bool isEditing = false;
  String? editingCategoryId;
  final TextEditingController nameController = TextEditingController();
  final AdminDashboardController dashboardController =
      Get.put(AdminDashboardController());

  @override
  void initState() {
    super.initState();
    dashboardController.fetchCategories();
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
            Text(
              "Show All Categories",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.buttoncolor),
            ),
            const SizedBox(height: 20),

            // Add / Update Category Form
            if (showAddCategory) ...[
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            isEditing ? "Update Category" : "Add Category",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.buttoncolor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          hintText: "Category Name",
                          controller: nameController,
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            CustomButton(
                              text:
                                  isEditing ? "Update Category" : "Add Category",
                              onPressed: () async {
                                String name = nameController.text.trim();
                                if (name.isEmpty) return;

                                String imageUrl;
                                switch (name.toLowerCase()) {
                                  case 'chair':
                                    imageUrl =
                                        'https://i.pinimg.com/736x/7b/7a/e6/7b7ae6371c1adcee2ff88de3d51e09b6.jpg';
                                    break;
                                  case 'sofa':
                                    imageUrl =
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBmbkPAo6z8clkkU9zmGtqaqyOutsn0D7GlQ&s';
                                    break;
                                  default:
                                    imageUrl =
                                        'https://cdn-icons-png.flaticon.com/512/679/679922.png';
                                }

                                final category = CategoryModel(
                                  id: editingCategoryId ?? '',
                                  title: name,
                                  image: imageUrl,
                                  productsCount: 0,
                                  description: '$name category',
                                  category: name,
                                  colors: [],
                                );

                                if (isEditing && editingCategoryId != null) {
                                  // 🔹 Update existing category
                                  await dashboardController
                                      .updateCategory(editingCategoryId!, category);
                                } else {
                                  // 🔹 Add new category
                                  await dashboardController
                                      .addCategory(category);
                                }

                                nameController.clear();
                                setState(() {
                                  showAddCategory = false;
                                  isEditing = false;
                                  editingCategoryId = null;
                                });
                              },
                            ),
                            const SizedBox(width: 50),
                            Image.asset(AppImage.profile, height: 50),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ] else ...[
              // Table header
              Container(
                decoration: BoxDecoration(
                  color: AppColor.textcolor,
                  border: Border.all(color: AppColor.textDark),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 140,
                      child: Text("Categories Image",
                          style: TextStyle(color: AppColor.buttoncolor)),
                    ),
                    Expanded(
                      child: Text("Categories Name",
                          style: TextStyle(color: AppColor.buttoncolor)),
                    ),
                    SizedBox(width: 150),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Categories list
              Expanded(
                child: Obx(() {
                  final categories = dashboardController.categories;

                  if (categories.isEmpty) {
                    return const Center(child: Text("No categories found"));
                  }

                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CategoryRow(
                        category: category,
                        onEdit: () {
                          nameController.text = category.title;
                          setState(() {
                            showAddCategory = true;
                            isEditing = true;
                            editingCategoryId = category.id;
                          });
                        },
                        onDelete: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Confirm Delete"),
                              content: Text(
                                  "Are you sure you want to delete ${category.title}?"),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Delete")),
                              ],
                            ),
                          );
                          if (confirm) {
                            await dashboardController
                                .deleteCategory(category.id);
                          }
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showAddCategory = true;
            isEditing = false;
            editingCategoryId = null;
            nameController.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}