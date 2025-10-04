import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/constant/app_image.dart';
import 'package:flutter/material.dart';

class Topbar extends StatefulWidget {
  const Topbar({super.key});

  @override
  State<Topbar> createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
   final bool hasUnreadNotifications = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
         
          child:Padding(
            padding: const EdgeInsets.only(left:400),
            child: SizedBox(
              width: 10,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                   enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColor.textDark),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColor.textDark),
        ),
                    filled: true,            
      fillColor: AppColor.textcolor,
                
                ),
              ),
            ),
          )
        ),
        const SizedBox(width: 20),
 
            Column(
                children: [
                
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5,
                        right:5),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        children: [
                          IconButton(onPressed: (){
                            // Get.toNamed('/notification');
                          },icon: Icon(
                          Icons.notifications_none,
                            color: Colors.black,
                            size: 28,
                          ),),
                          if (hasUnreadNotifications)
                            Positioned(
                              top: 10,
                              right: 14,
                              child: Container(
                                width: 8,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
              
            

        const SizedBox(width: 10),
         CircleAvatar(
          backgroundImage: AssetImage(
            AppImage.profile),
        ),
      ],

    );
  }
}
