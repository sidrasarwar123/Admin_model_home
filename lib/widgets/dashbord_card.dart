import 'package:admin_model_home/constant/app_color.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  const DashboardCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: AppColor.textcolor,
        border: Border.all(color: AppColor.buttoncolor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
       
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, color: AppColor.buttoncolor, size: 30),
            const SizedBox(height: 6),
            Text(
              title,
              style:  TextStyle(fontWeight: FontWeight.bold,color: AppColor.buttoncolor,fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style:  TextStyle(color: AppColor.buttoncolor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
