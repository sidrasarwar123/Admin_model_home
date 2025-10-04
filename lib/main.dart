import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/constant/app_image.dart';
import 'package:admin_model_home/routes/app_routes.dart';
import 'package:admin_model_home/widgets/custom_button.dart';
import 'package:admin_model_home/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
   return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

        
          initialRoute: '/myhome',  

        
          getPages: AppRoutes.routes,

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
class myhome extends StatefulWidget {
  const myhome({super.key});

  @override
  State<myhome> createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {
     final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.all(16),
          width: screenWidth > 650 ? 550 : double.infinity,
          decoration: BoxDecoration(
            color: AppColor.textcolor,
            borderRadius: BorderRadius.circular(12),
         
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImage.login, height: 200),
                    const SizedBox(height: 12),
                  ],
                ),
            
              const SizedBox(width: 30),

              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                       Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: AppColor.textDark),
                    ),
                    const SizedBox(height: 10),

                    CustomTextField(
                       hintText: "Email", controller:emailController ),
                    const SizedBox(height: 16),
                        Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: AppColor.textDark),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                        hintText: "Password",
                        controller: passwordController,
                       isPassword: true,
                       
                        ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50,top: 40),
                      child: CustomButton(
                        text: "Login",
                        onPressed: () {
                  Get.toNamed('/sidebar', );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

