import 'package:admin_model_home/main.dart';
import 'package:admin_model_home/view/screens/category_screen.dart';

import 'package:admin_model_home/view/screens/dashbord_screen.dart';
import 'package:admin_model_home/view/screens/product_screen.dart';
import 'package:admin_model_home/widgets/sidebar_menu.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
   static final routes=[
      GetPage(name: '/myhome', page: ()=>MyHome()),
      GetPage(name: '/dashbord', page: ()=>DashboardScreen()), 
      GetPage(name: '/sidebar', page: ()=>SidebarMenu()),
    GetPage(name: '/categoryscreen', page: ()=>CategoryScreen()),
        GetPage(name:'/productscreen', page: ()=>ProductScreen()),
   
   ];
}