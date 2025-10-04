import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/models/category_model.dart';
import 'package:flutter/material.dart';


class CategoryRow extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CategoryRow({
    super.key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: Row(
        children: [
        
          SizedBox(
            width: 100,
            child: Image.asset(category.imageUrl, height: 40, fit: BoxFit.cover),
          ),
          SizedBox(width: 60,),
          Expanded(
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 16),
            ),
          ),

  
          SizedBox(
            width: 90,
            child: ElevatedButton.icon(
              onPressed: onEdit,
              style: ElevatedButton.styleFrom(backgroundColor: AppColor.buttoncolor,shape: 
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
              ),
              icon:  Icon(Icons.edit, size: 16,color: AppColor.textcolor,),
              label:  Text("Edit",style: TextStyle(color: AppColor.textcolor),),
            ),
          ),
          const SizedBox(width: 8),

          SizedBox(
            width: 90,
            child: ElevatedButton.icon(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red,shape: 
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
              ),
              label:  Text("Delete",style: TextStyle(color: AppColor.textcolor),),
            ),
          ),
        ],
      ),
    );
  }
}
