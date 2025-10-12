import 'package:admin_model_home/constant/app_color.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';

class ProductRow extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductRow({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: Row(
        children: [
         SizedBox(
  width: 100,
  height: 60,
  child: product.image.isNotEmpty
      ? Image.network(
          product.image,
          height: 40,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
          },
        )
      : const Icon(Icons.category, size: 40),
),
           SizedBox(width: 60,),
        Expanded(
  child: Text(
    product.title ?? "No Name",
    style: const TextStyle(fontSize: 16),
  ),
        ),
      
          Expanded(child: Text(   product.price.toStringAsFixed(2),),),
          Expanded(child: Text(product.description, overflow: TextOverflow.ellipsis,
  maxLines: 1, 
          )),
          SizedBox(
            width: 250,
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                  label: const Text("Edit", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.Confirm,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  icon: const Icon(Icons.delete, size: 16, color: Colors.white),
                  label: const Text("Delete", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
