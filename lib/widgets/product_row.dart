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
            width: 90,
            child: Image.asset(product.imageUrl, height: 40, fit: BoxFit.cover),
          ),SizedBox(width: 30,),
          Expanded(child: Text(product.name)),
      
          Expanded(child: Text(product.experience)),
          Expanded(child: Text(product.description)),
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
                    backgroundColor: Colors.red,
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
