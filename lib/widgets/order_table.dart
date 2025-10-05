import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/models/pending_order.dart';
import 'package:flutter/material.dart';

class OrderTable extends StatelessWidget {
  OrderTable({super.key});

  final List<OrderModel> orders = [
    OrderModel(id: 1, name: "Salim", qty: 1, address: "Near Meadows School"),
    OrderModel(id: 2, name: "Ahmad", qty: 2, address: "Street 4, Lahore"),
    OrderModel(id: 3, name: "Ali", qty: 3, address: "Karachi"),
    OrderModel(id: 4, name: "Asif", qty: 2, address: "Islamabad"),
    OrderModel(id: 5, name: "Huzaifa", qty: 2, address: "Rawalpindi"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: AppColor.gray,
        ),
        child: DataTable(
          dividerThickness: 0.8,
          columnSpacing: 40,
          headingRowColor:
              WidgetStateProperty.all(AppColor.textcolor), 
          columns: [
            DataColumn(
                label: Text("Sr No",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
            DataColumn(
                label: Text("Product name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
            DataColumn(
                label: Text("Qty",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
            DataColumn(
                label: Text("Address",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
            DataColumn(
                label: Text("Confirm",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
            DataColumn(
                label: Text("Delete",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
          ],
          rows: orders.map((order) {
            return DataRow(cells: [
              DataCell(Text(order.id.toString())),
              DataCell(Text(order.name)),
              DataCell(Text(order.qty.toString())),
              DataCell(Text(order.address)),
              DataCell(
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.Confirm,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),),
                  onPressed: () {},
                  child: Text("Confirm",style: TextStyle(color: AppColor.textcolor),),
                ),
              ),
              DataCell(
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColor.Delete, 
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),),
                  onPressed: () {},
                  child:  Text("Delete",style: TextStyle(color: AppColor.textcolor),)
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
