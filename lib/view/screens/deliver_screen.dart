import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/widgets/delider_order_table.dart';
import 'package:admin_model_home/widgets/top_bar.dart';
import 'package:flutter/material.dart';


class DeliverOrderScreen extends StatelessWidget {
  const DeliverOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Topbar(),
            Padding(
              padding: const EdgeInsets.only(right: 550,top: 20),
              child:  Text(
                "All Deliver order",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: AppColor.buttoncolor),
              ),
            ),
            const SizedBox(height: 30),
           
             DeliverOrderTable(),
          ]
        ),
      ),); 
  }
}
