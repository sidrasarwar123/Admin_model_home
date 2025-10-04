import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/view/screens/category_screen.dart';
import 'package:admin_model_home/view/screens/dashbord_screen.dart';
import 'package:admin_model_home/view/screens/product_screen.dart';
import 'package:flutter/material.dart';



class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Order Management Screen", style: TextStyle(fontSize: 24)),
    );
  }
}


class SidebarMenu extends StatefulWidget {
  final int initialIndex; 

  const SidebarMenu({super.key, this.initialIndex = 0});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.dashboard, "text": "Dashboard"},
    {"icon": Icons.group_outlined, "text": "Show All Categories"},
    {"icon": Icons.shopping_bag, "text": "Show All Product"},
    {"icon": Icons.list_alt, "text": "Order Management"},
  ];

  final List<Widget> screens = const [
   DashboardScreen(),
   CategoryScreen(),
   ProductScreen(),
    OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
        
          Container(
            width: 220,
            height: double.infinity,
            color:AppColor.buttoncolor, 
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildMenuItem(
                      menuItems[index]["icon"],
                      menuItems[index]["text"],
                      selectedIndex == index,
                      () {
                        setState(() {
                          selectedIndex = index; 
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),

          // ✅ Screen change with click
          Expanded(
            child: screens[selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon, String text, bool selected, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: selected
            ? []
            : [],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: selected ? AppColor.buttoncolor : AppColor.textcolor,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: selected ?AppColor.buttoncolor : AppColor.textcolor,fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
