import 'package:admin_model_home/widgets/custom_button.dart';
import 'package:admin_model_home/widgets/custom_textfeild.dart';
import 'package:admin_model_home/widgets/product_row.dart';

import 'package:admin_model_home/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_color.dart';
import '../../constant/app_image.dart';
import '../../models/product_model.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool showUpdateProduct = false;
  final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
      final TextEditingController priceController = TextEditingController();
            final TextEditingController productNameController = TextEditingController();

  final products = [
    ProductModel(
        name: "Saim",
        experience: "Plumber",
        description: "Plumber",
        imageUrl: AppImage.image),
    ProductModel(
        name: "Ahmad",
        experience: "Plumber",
        description: "Plumber",
        imageUrl: AppImage.image),
    ProductModel(
        name: "Ali",
        experience: "Plumber",
        description: "Plumber",
        imageUrl: AppImage.image),
  ];

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
              "Show All products",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.buttoncolor),
            ),
            const SizedBox(height: 20),

            if (showUpdateProduct) ...[
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
            ] else ...[
       
              Container(
                decoration: BoxDecoration(
                  color: AppColor.textcolor,
                  border: Border.all(color: AppColor.textDark),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child:Row(
  children: [
    SizedBox(
      width: 120,
      child: Text(
        "Product Image",
        style: TextStyle(color: AppColor.buttoncolor),
      ),
    ),
    SizedBox(
      width:120,
      child: Text(
        "Name",
        style: TextStyle(color: AppColor.buttoncolor),
      ),
    ),
    SizedBox(
      width: 120,
      child: Text(
        "Experience",
        style: TextStyle(color: AppColor.buttoncolor),
      ),
    ),
    SizedBox(
      width: 160,
      child: Text(
        "Description",
        style: TextStyle(color: AppColor.buttoncolor),
      ),
    ),
  ],
)

              ),
              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final category = products[index];
                    return ProductRow(
                      product: category,
                      onEdit: () {
                        setState(() {
                          showUpdateProduct = true; 
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
