import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/widgets/order_table.dart';
import 'package:admin_model_home/widgets/top_bar.dart';
import 'package:flutter/material.dart';


class PendingOrdersScreen extends StatelessWidget {
  const PendingOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
           Topbar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                     Text(
                      "All Pending Orders",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.buttoncolor),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: OrderTable(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
