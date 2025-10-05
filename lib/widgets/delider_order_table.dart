import 'package:admin_model_home/models/deliver_model.dart';
import 'package:flutter/material.dart';
import 'package:admin_model_home/constant/app_color.dart';


class DeliverOrderTable extends StatelessWidget {
  DeliverOrderTable({super.key});

  final List<DeliverOrderModel> orders = [
    DeliverOrderModel(
        id: 1,
        name: "Salim",
        booked: "Plumber",
        address: "Near Meadows School",
        amount: 2000),
    DeliverOrderModel(
        id: 2,
        name: "Ahmad",
        booked: "Plumber",
        address: "Faisalabad",
        amount: 0),
    DeliverOrderModel(
        id: 3,
        name: "Ali",
        booked: "Plumber",
        address: "Lahore",
        amount: 0),
    DeliverOrderModel(
        id: 4,
        name: "Asif",
        booked: "Plumber",
        address: "Karachi",
        amount: 0),
    DeliverOrderModel(
        id: 5,
        name: "Huzaifa",
        booked: "Plumber",
        address: "Islamabad",
        amount: 0),
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
          columnSpacing: 49,
          headingRowColor:
              WidgetStateProperty.all(AppColor.textcolor),
          columns: [
            DataColumn(
                label: Text("Sr No",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
            DataColumn(
                label: Text("Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
            DataColumn(
                label: Text("Booked",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
            DataColumn(
                label: Text("Address",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.buttoncolor))),
            DataColumn(
                label: Text("Amount",
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
              DataCell(Text(order.booked)),
              DataCell(Text(order.address)),
              DataCell(Text(order.amount.toString())),
              DataCell(
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.Delete,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                  onPressed: () {},
                  child:  Text("Delete",
                      style: TextStyle(color: AppColor.textcolor)),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
