import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/constant/app_image.dart';
import 'package:admin_model_home/widgets/custom_button.dart';
import 'package:admin_model_home/widgets/custom_textfeild.dart';
import 'package:admin_model_home/widgets/dashbord_card.dart';
import 'package:admin_model_home/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool showAddCategory = false;
  bool showAddProduct = false;

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

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
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3,
                        children: const [
                          DashboardCard(title: "Total User", value: "17"),
                          DashboardCard(title: "Total Order", value: "17"),
                          DashboardCard(title: "Total Amount", value: "400007"),
                          DashboardCard(title: "Pending Order", value: "17"),
                        ],
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
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                            label: Text(
                              "Add Categories",
                              style: TextStyle(
                                  color: AppColor.textcolor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 50),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.buttoncolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                            label: Text(
                              "Add Product",
                              style: TextStyle(
                                  color: AppColor.textcolor,
                                  fontWeight: FontWeight.bold),
                            ),
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Add Categories",
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
                                padding: const EdgeInsets.only(
                                    right: 300, top: 15),
                                child: CustomTextField(
                                    hintText: "Name",
                                    controller: nameController),
                              ),
                              const SizedBox(height: 60),
                              Padding(
                                padding: const EdgeInsets.only(left: 200,top: 40),
                                child: Row(
                                  children: [
                                    
                                    CustomButton(
                                      text: "Add Category",
                                      onPressed: () {
                                        Get.offNamed('/categoryscreen');
                                       
                                      },
                                    ),
                                    SizedBox(width:50,),
                                    Image(image: AssetImage(AppImage.profile))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]

              
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Add Product",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.buttoncolor,
                                      ),
                                    ),
                                    Image(image: AssetImage(AppImage.profile))
                                  ],
                                ),  
                                  const SizedBox(height: 40),
                                  Row(
                                    children: [
                                      Expanded(child:
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         Text(
                                  "Product Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                 Padding(
                                padding: const EdgeInsets.only(
                                top: 15),
                                child: CustomTextField(
                                    hintText: " Name",
                                    controller: productNameController),
                              ),
                          ], 
                                      )
                                       
                                      ),SizedBox(width: 40,),
                                       Expanded(child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                              Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                 Padding(
                                padding: const EdgeInsets.only(
                                   top: 15),
                                child: CustomTextField(
                                    hintText: "Description",
                                    controller: descriptionController),
                              ),
                             ], 
                            ))
                                    ],
                                  ),
                                          const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Price *",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 300, top: 15),
                                child: CustomTextField(
                                    hintText: "Price",
                                    controller: priceController),
                              ),

                              const SizedBox(height: 60),
                              CustomButton(
                                text: "Add Product",
                                onPressed: () {
                               Get.offNamed("/productscreen");
                                },
                              ),
                      
                            ],
                          ),
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
