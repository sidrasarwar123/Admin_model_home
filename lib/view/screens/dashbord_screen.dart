import 'package:admin_model_home/controller/dashboard_controller.dart';
import 'package:admin_model_home/models/category_model.dart';
import 'package:admin_model_home/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_color.dart';
import '../../constant/app_image.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfeild.dart';
import '../../widgets/dashbord_card.dart';
import '../../widgets/top_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool showAddCategory = false;
  bool showAddProduct = false;
  String? selectedCategory;

  // Controllers
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  

  final AdminDashboardController dashboardController =
      Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Topbar(),
                  const SizedBox(height: 20),

                  // Default Dashboard
                  if (!showAddCategory && !showAddProduct) ...[
                    Expanded(
                      child: FutureBuilder<Map<String, dynamic>>(
                        future: dashboardController.getDashboardStats(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final data = snapshot.data!;
                          return GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 3,
                            children: [
                              DashboardCard(
                                  title: "Total Users",
                                  value: data['users'].toString()),
                              DashboardCard(
                                  title: "Total Orders",
                                  value: data['orders'].toString()),
                              DashboardCard(
                                  title: "Total Amount",
                                  value: data['amount'].toStringAsFixed(2)),
                              DashboardCard(
                                  title: "Pending Orders",
                                  value: data['pending'].toString()),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100, right: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.buttoncolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 30),
                            ),
                            onPressed: () {
                              setState(() {
                                showAddCategory = true;
                                showAddProduct = false;
                              });
                            },
                            icon: Icon(Icons.add, color: AppColor.textcolor),
                            label: Text("Add Category",
                                style: TextStyle(
                                    color: AppColor.textcolor,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 50),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.buttoncolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 30),
                            ),
                            onPressed: () {
                              setState(() {
                                showAddProduct = true;
                                showAddCategory = false;
                              });
                            },
                            icon: Icon(Icons.add, color: AppColor.textcolor),
                            label: Text("Add Product",
                                style: TextStyle(
                                    color: AppColor.textcolor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ]

                  // Add Category Form
                  else if (showAddCategory) ...[
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
                              Text("Add Category",
                                  style: TextStyle(
                                      color: AppColor.buttoncolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              const SizedBox(height: 20),
                              CustomTextField(
                                  hintText: "Category Name",
                                  controller: categoryController),
                              const SizedBox(height: 40),

                          
                              Obx(() => dashboardController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : CustomButton(
                                      text: "Add Category",
                                      onPressed: () async {
                                        String name =
                                            categoryController.text.trim();

                                        if (name.isEmpty) return;

                                        // Choose image based on category name
                                        String imageUrl;
                                        if (name.toLowerCase() == 'chair') {
                                          imageUrl =
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg6pAkmwY3_PQNR5OVwcJA8c9Rrzqg5Du7hktX-dsuJCb8EG8GKTACQa8AyIXTC6_2tfo&usqp=CAU';
                                        } else if (name.toLowerCase() ==
                                            'sofa') {
                                          imageUrl =
                                              'https://www.modishstore.com/cdn/shop/products/EEI-1179-CIT_1.jpg?v=1756751804&width=533';
                                        } else if (name.toLowerCase() ==
                                            'table') {
                                          imageUrl =
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsBApcQDmTIlcTN32PzXvG-JJiZFYBScWAcQ&s';
                                        } else {
                                          imageUrl =
                                              'https://cdn-icons-png.flaticon.com/512/679/679922.png';
                                        }

                                        // Create and add category
                                        final category = CategoryModel(
                                          id: '',
                                          title: name,
                                          image: imageUrl,
                                          productsCount: 0,
                                          description: '$name category',
                                          category: name,
                                          colors: [],
                                        );

                                        await dashboardController
                                            .addCategory(category);

                                        categoryController.clear();
                                        setState(() {
                                          showAddCategory = false;
                                        });
                                      },
                                    )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]

                  // Add Product Form
               // Add Product Form
else if (showAddProduct) ...[
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
        child: Obx(() {
          // Duplicate-free category list
          final categoryItems = dashboardController.categories
              .map((cat) => cat.title)
              .toSet()
              .toList();

          
          if (selectedCategory != null && !categoryItems.contains(selectedCategory)) {
            selectedCategory = null;
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add Product",
                        style: TextStyle(
                            color: AppColor.buttoncolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Image.asset(AppImage.profile, height: 50),
                  ],
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Product Name",
                  controller: productNameController,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Description",
                  controller: descriptionController,
                ),
                const SizedBox(height: 20),

                // Safe Dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Category',
                  ),
                  value: selectedCategory,
                  hint: const Text("Select Category"),
                  items: categoryItems
                      .map((title) => DropdownMenuItem(
                            value: title,
                            child: Text(title),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val;
                    });
                  },
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Price",
                  controller: priceController,
                ),
                const SizedBox(height: 40),

                dashboardController.isLoading.value
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: "Add Product",
                        onPressed: () async {
                          final colors = colorController.text
                              .split(',')
                              .map((e) => e.trim())
                              .where((e) => e.isNotEmpty)
                              .toList();

                          String categoryName =
                              selectedCategory ?? 'General';

                          // Dynamic image based on category
                          String imageUrl;
                          switch (categoryName.toLowerCase()) {
                            case 'chair':
                              imageUrl =
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBmbkPAo6z8clkkU9zmGtqaqyOutsn0D7GlQ&s';
                              break;
                            case 'table':
                              imageUrl =
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS68eTvlIapVJnaRoN1fIIGPdAgtg1XQU9uOw&s';
                              break;
                            case 'sofa':
                              imageUrl =
                                  'https://static.vecteezy.com/system/resources/previews/022/219/389/non_2x/white-sofa-isolated-on-a-transparent-background-png.png';
                              break;
                            case 'bed':
                              imageUrl =
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-mMoo5HpHtNNaHWFxTdQJRCy_VWti204yNA&s';
                              break;
                            case 'lamp':
                              imageUrl =
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMML_qfkQ6UnTKH0qFTxP7aDrhZCMLhncusA&s';
                              break;
                            default:
                              imageUrl =
                                  'https://cdn-icons-png.flaticon.com/512/679/679922.png';
                          }

                          final product = ProductModel(
                            id: '',
                            title: productNameController.text.trim(),
                            category: categoryName,
                            price:
                                double.tryParse(priceController.text) ?? 0.0,
                            description: descriptionController.text.trim(),
                            colors: colors,
                            image: imageUrl,
                          );

                          await dashboardController.addProduct(product);

                          productNameController.clear();
                          descriptionController.clear();
                          priceController.clear();
                          colorController.clear();
                          selectedCategory = null;

                          setState(() {
                            showAddProduct = false;
                          });
                        },
                      ),
              ],
            ),
          );
        }),
      ),
    ),
  ),
],

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
