import 'package:admin_model_home/constant/app_color.dart';
import 'package:admin_model_home/utils/loading_utils.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
final VoidCallback? onPressed;
    final bool? isloading;

  const CustomButton({
    super.key,
      this.isloading=false,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:AppColor.buttoncolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,

           child:isloading==true?
        LoadingUtil.buttonLoading():
        Text(text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
      ),
    );
  }
}
