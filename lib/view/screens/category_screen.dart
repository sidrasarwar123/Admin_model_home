import 'package:admin_model_home/constant/app_image.dart';
import 'package:admin_model_home/models/category_model.dart';
import 'package:admin_model_home/widgets/custom_textfeild.dart';
import 'package:admin_model_home/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import '../../../constant/app_color.dart';
import '../../widgets/category_row.dart';
import '../../widgets/custom_button.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool showupdateCategory = false;
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categories = [
      CategoryModel(name: "Chair", imageUrl: AppImage.image),
      CategoryModel(name: "Sofa", imageUrl: AppImage.image),
      CategoryModel(name: "Plumber", imageUrl: AppImage.image),
      CategoryModel(name: "Carpenter", imageUrl: AppImage.image),
    ];

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

            if (showupdateCategory) ...[
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
                            "Update Categories",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.buttoncolor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Category Name *",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 300, top: 15),
                          child: CustomTextField(
                              hintText: "Name",
                              controller: nameController),
                        ),
                        const SizedBox(height: 60),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 200, top: 40),
                          child: Row(
                            children: [
                              CustomButton(
                                text: "Add Category",
                                onPressed: () {
                             
                                  setState(() {
                                    showupdateCategory = false; 
                                  });
                                  Get.snackbar("Success",
                                      "Category Added: ${nameController.text}");
                                },
                              ),
                              const SizedBox(width: 50),
                              Image(image: AssetImage(AppImage.profile))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ] else ...[
       
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
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryRow(
                      category: category,
                      onEdit: () {
                        setState(() {
                          showupdateCategory = true; 
                        });
                      },
                      onDelete: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Delete ${category.name}")),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
