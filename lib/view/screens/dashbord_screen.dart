
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

 late final AdminDashboardController dashboardController;

@override
void initState() {
  super.initState();
  dashboardController = Get.put(AdminDashboardController(), permanent: true);
}

  @override
  void dispose() {
    // Dispose all text controllers safely
    categoryController.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    colorController.dispose();
    super.dispose();
  }

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
                              if (!mounted) return;
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
                              if (!mounted) return;
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
                                        String name = categoryController.text;
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
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHqA_EjO1CzOVvhh9FTRHYOF7sf_7uW8uDRg&s';
                                        } else {
                                          imageUrl =
                                              'https://cdn-icons-png.flaticon.com/512/679/679922.png';
                                        }

                                        final category = CategoryModel(
                                          id: '',
                                          title: name,
                                          image: imageUrl,
                                          productsCount: 0,
                                          description: '$name category',
                                          category: name,
                                          colors: [],
                                        );

                                        final categoryId =
                                            await dashboardController
                                                .addCategory(category);

                                        if (categoryId != null) {
                                          List<ProductModel> defaultProducts =
                                              [];

                                          switch (name.toLowerCase()) {
                                            case 'chair':
                                              defaultProducts = [
                                                ProductModel(
                                                  id: '',
                                                  title: 'Wooden Chair',
                                                  category: name,
                                                  price: 2500,
                                                  description:
                                                      'A chair is a piece of furniture designed for one person to sit on, typically featuring a seat, a back, and legs for support. However, the term "chair" can also refer to the person who leads a meeting or holds a professorial position at a university.', 

                                                  colors: ['Brown', 'Black'],
                                                  image:
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBmbkPAo6z8clkkU9zmGtqaqyOutsn0D7GlQ&s',
                                                ),
                                                ProductModel(
                                                  id: '',
                                                  title: 'Modern Chair',
                                                  category: name,
                                                  price: 2500,
                                                  description:
                                                      'A chair is a piece of furniture designed for one person to sit on, typically featuring a seat, a back, and legs for support. However, the term "chair" can also refer to the person who leads a meeting or holds a professorial position at a university.  ',

                                                  colors: ['Brown', 'Black'],
                                                  image:
                                                      'https://i.pinimg.com/736x/7b/7a/e6/7b7ae6371c1adcee2ff88de3d51e09b6.jpg',
                                                ),
                                                ProductModel(
                                                  id: '',
                                                  title: 'Plastic Chair',
                                                  category: name,
                                                  price: 1200,
                                                  description:
                                                      'A chair is a piece of furniture designed for one person to sit on, typically featuring a seat, a back, and legs for support. However, the term "chair" can also refer to the person who leads a meeting or holds a professorial position at a university.  ',
                                                  colors: ['White', 'Brown'],
                                                  image:
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0ByX8UKkSwhSVQdLCOA8DAdSAyiCJuf_1lmnL5H4UTKmPkYoRE_1rKE_Anno1OAcWPls&usqp=CAU',
                                                ),
                                                ProductModel(
                                                  id: '',
                                                  title: 'Arm Chair',
                                                  category: name,
                                                  price: 1200,
                                                  description:
                                                      'A chair is a piece of furniture designed for one person to sit on, typically featuring a seat, a back, and legs for support. However, the term "chair" can also refer to the person who leads a meeting or holds a professorial position at a university.  ',
                                                  colors: ['White', 'Brown'],
                                                  image:
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCpZ63yq5YRbpS5WqGzA-Hq_rBxrPliUROyA&s',
                                                ),
                                              ];
                                              break;

                                            case 'sofa':
                                              defaultProducts = [
                                                ProductModel(
                                                  id: '',
                                                  title: 'Leather Sofa',
                                                  category: name,
                                                  price: 15000,
                                                  description:
                                                      'A sofa is a long, upholstered seat with a back and arms that can comfortably seat two or more people. It is a common piece of furniture found in living rooms and is often used for relaxation, conversation, or watching television. While the term "sofa" is more prevalent in British English, the furniture is also known as a "couch" in American English.  ',
                                                  colors: ['Black', 'Gray'],
                                                  image:
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTstI2dT-H_ut0_fI5x_1o2hMg9sIRXPQXcg&s',
                                                ),
                                                 ProductModel(
                                                  id: '',
                                                  title: 'Bloom Sofa',
                                                  category: name,
                                                  price: 15000,
                                                  description:
                                                      'A sofa is a long, upholstered seat with a back and arms that can comfortably seat two or more people. It is a common piece of furniture found in living rooms and is often used for relaxation, conversation, or watching television. While the term "sofa" is more prevalent in British English, the furniture is also known as a "couch" in American English.  ',
                                                  colors: ['Black', 'Gray'],
                                                  image:
                                                      'https://t3.ftcdn.net/jpg/07/40/06/02/360_F_740060239_eGZu2uqTX0bIVdmOEZykt54i8AMg5bzg.jpg',
                                                ),
                                                 ProductModel(
                                                  id: '',
                                                  title: 'Ruben Sofa',
                                                  category: name,
                                                  price: 15000,
                                                  description:
                                                      'A sofa is a long, upholstered seat with a back and arms that can comfortably seat two or more people. It is a common piece of furniture found in living rooms and is often used for relaxation, conversation, or watching television. While the term "sofa" is more prevalent in British English, the furniture is also known as a "couch" in American English.  ',
                                                  colors: ['Black', 'Gray'],
                                                  image:
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX9lMK4WstOKSlqDaJLb-WCQYxD8KZifRoFPWT5e1bZ3NA1ujyo91Nud01Czxwp41-r1w&usqp=CAU',
                                                ),
                                                ProductModel(
                                                  id: '',
                                                  title: 'Fabric Sofa',
                                                  category: name,
                                                  price: 10000,
                                                  description:
                                                      'A sofa is a long, upholstered seat with a back and arms that can comfortably seat two or more people. It is a common piece of furniture found in living rooms and is often used for relaxation, conversation, or watching television. While the term "sofa" is more prevalent in British English, the furniture is also known as a "couch" in American English.  ',
                                                  colors: ['Blue', 'Beige'],
                                                  image:
                                                      'https://thumbs.dreamstime.com/b/modern-blue-sofa-shadow-isolated-transparent-background-furniture-interior-minimalist-design-png-file-297533427.jpg',
                                                ),
                                              ];
                                              break;

                                            case 'table':
                                              defaultProducts = [
                                                ProductModel(
                                                  id: '',
                                                  title: 'Dining Table',
                                                  category: name,
                                                  price: 7000,
                                                  description:
                                                      'A "description of a table" can refer to either the piece of furniture with a flat top and legs or a structured arrangement of data in rows and columns. As furniture, a table is a surface for eating, writing, or placing objects. As a data structure, it organizes information for quick reference and analysis. ',
                                                  colors: ['Brown', 'Black'],
                                                  image:
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSlE0DIV73Lf7DAsAcOq51Au7Cle46vyFXPcB92boTdcUX3BKJCGISk3HNtbhNQEyYQj8&usqp=CAU',
                                                ),
                                                  ProductModel(
                                                  id: '',
                                                  title: 'Solid Wood Table',
                                                  category: name,
                                                  price: 7000,
                                                  description:
                                                      'A "description of a table" can refer to either the piece of furniture with a flat top and legs or a structured arrangement of data in rows and columns. As furniture, a table is a surface for eating, writing, or placing objects. As a data structure, it organizes information for quick reference and analysis. ',
                                                  colors: ['Brown', 'Black'],
                                                  image:
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQANZOltguBVuQZsVUlwuJ3VprfjCTKQBTEpaHYuk2oSpi6c5riIAZO7VOUI1jL1Bl0-Z0&usqp=CAUhttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQANZOltguBVuQZsVUlwuJ3VprfjCTKQBTEpaHYuk2oSpi6c5riIAZO7VOUI1jL1Bl0-Z0&usqp=CAU',
                                                ),
                                                  ProductModel(
                                                  id: '',
                                                  title: 'chinese Table',
                                                  category: name,
                                                  price: 4000,
                                                  description:
                                                      'A "description of a table" can refer to either the piece of furniture with a flat top and legs or a structured arrangement of data in rows and columns. As furniture, a table is a surface for eating, writing, or placing objects. As a data structure, it organizes information for quick reference and analysis. ',
                                                  colors: ['Brown', 'Black'],
                                                  image:
                                                      'https://static.vecteezy.com/system/resources/previews/047/242/514/non_2x/chinese-stone-black-dining-table-isolated-on-transparent-background-free-png.png',
                                                ),
                                                ProductModel(
                                                  id: '',
                                                  title: 'Coffee Table',
                                                  category: name,
                                                  price: 4000,
                                                  description:
                                                      'A "description of a table" can refer to either the piece of furniture with a flat top and legs or a structured arrangement of data in rows and columns. As furniture, a table is a surface for eating, writing, or placing objects. As a data structure, it organizes information for quick reference and analysis. ',
                                                  colors: ['Brown', 'Black'],
                                                  image:
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRmfQiG-4onelUdgkOyw97LzpsdBOBk_gDgzFL7MOUYZyK15BUy-He1Y3Vb9VzeLe25eM&usqp=CAU',
                                                ),
                                              ];
                                              break;
                                          }

                                          // Save products and update count
                                          for (var product
                                              in defaultProducts) {
                                            await dashboardController
                                                .addProductToCategory(
                                                    categoryId, product);
                                          }
                                          await dashboardController
                                              .updateCategoryProductCount(
                                                  categoryId,
                                                  defaultProducts.length);
                                        }

                                       if (!mounted) return;
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

                  // ===================== ADD PRODUCT FORM =====================
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
                            final categoryItems = dashboardController.categories
                                .map((cat) => cat.title)
                                .toSet()
                                .toList();

                            if (selectedCategory != null &&
                                !categoryItems
                                    .contains(selectedCategory)) {
                              selectedCategory = null;
                            }

                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      if (!mounted) return;
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
                                            final colors =
                                                colorController.text
                                                    .split(',')
                                                    .map((e) => e.trim())
                                                    .where((e) =>
                                                        e.isNotEmpty)
                                                    .toList();

                                            String categoryName =
                                                selectedCategory ??
                                                    'General';

                                            // Dynamic image based on category
                                            String imageUrl;
                                            switch (categoryName
                                                .toLowerCase()) {
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
                                              title: productNameController.text
                                                  .trim(),
                                              category: categoryName,
                                              price: double.tryParse(
                                                      priceController.text) ??
                                                  0.0,
                                              description:
                                                  descriptionController.text
                                                      .trim(),
                                              colors: colors,
                                              image: imageUrl,
                                            );

                                            await dashboardController
                                                .addProduct(product);

                                            if (!mounted) return;
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
