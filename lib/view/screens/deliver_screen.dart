import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/controller/order_controller.dart';

import 'package:admin_model_home/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class DeliverOrderScreen extends StatefulWidget {
  const DeliverOrderScreen({super.key});

  @override
  State<DeliverOrderScreen> createState() => _DeliverOrderScreenState();
}

class _DeliverOrderScreenState extends State<DeliverOrderScreen> {
    final OrderController orderController = Get.find<OrderController>();
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
          Obx(() {
      if (orderController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (orderController.deliveredOrders.isEmpty) {
        return const Center(child: Text("No Delivered Orders Found"));
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: AppColor.gray),
          child: DataTable(
            dividerThickness: 0.8,
            columnSpacing: 49,
            headingRowColor:
                WidgetStateProperty.all(AppColor.textcolor),
            columns: _columns(),
            rows: _rows(),
          ),
        ),
      );
    }),
           
          ]
        ),
      ),); 
  }

   List<DataColumn> _columns() => [
        DataColumn(label: Text("Sr No", style: _heading())),
        DataColumn(label: Text("Product", style: _heading())),
        DataColumn(label: Text("Qty", style: _heading())),
        DataColumn(label: Text("Address", style: _heading())),
        DataColumn(label: Text("Delete", style: _heading())),
      ];

  List<DataRow> _rows() {
    return orderController.deliveredOrders.asMap().entries.map((entry) {
      final index = entry.key;
      final order = entry.value;

      return DataRow(cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(order.productName)),
        DataCell(Text(order.qty.toString())),
        DataCell(Text(order.address)),
        DataCell(
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.Delete,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: () => orderController.deleteOrder(order.id),
            child: Text("Delete", style: TextStyle(color: AppColor.textcolor)),
          ),
        ),
      ]);
    }).toList();
  }

  TextStyle _heading() =>
      TextStyle(fontWeight: FontWeight.bold, color: AppColor.buttoncolor);
}


