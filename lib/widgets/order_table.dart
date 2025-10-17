import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTable extends StatefulWidget {

  OrderTable({super.key});

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (orderController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (orderController.pendingOrders.isEmpty) {
        return const Center(child: Text("No Pending Orders Found"));
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: AppColor.gray),
          child: DataTable(
            dividerThickness: 0.8,
            columnSpacing: 40,
            headingRowColor: WidgetStateProperty.all(AppColor.textcolor),
            columns: [
              DataColumn(label: Text("Sr No", style: _headingStyle())),
              DataColumn(label: Text("Product name", style: _headingStyle())),
              DataColumn(label: Text("Qty", style: _headingStyle())),
              DataColumn(label: Text("Address", style: _headingStyle())),
              DataColumn(label: Text("Confirm", style: _headingStyle())),
              DataColumn(label: Text("Delete", style: _headingStyle())),
            ],
            rows: orderController.pendingOrders.asMap().entries.map((entry) {
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
                      backgroundColor: AppColor.Confirm,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    onPressed: () {
                     orderController.updateOrderStatus(order.id, 'delivered');},
                    child: Text("Confirm",
                        style: TextStyle(color: AppColor.textcolor)),
                  ),
                ),
                DataCell(
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.Delete,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    onPressed: () {
                      orderController.deleteOrder(order.id);
                    },
                    child: Text("Delete",
                        style: TextStyle(color: AppColor.textcolor)),
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      );
    });
  }

  TextStyle _headingStyle() => TextStyle(
      fontWeight: FontWeight.bold, color: AppColor.buttoncolor);
}
