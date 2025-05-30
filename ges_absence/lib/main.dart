import 'package:flutter/material.dart';
import 'package:ges_absence/app/bindings/global_binding.dart';
import 'package:ges_absence/app/routes/app_pages.dart';
import 'package:ges_absence/theme/colors.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ISM Ges Absence',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.secondaryColor,
        ),
        fontFamily: 'Roboto',
      ),
      initialBinding: GlobalBinding(),
      initialRoute: AppPages.initial, 
      getPages: AppPages.pages, 
      debugShowCheckedModeBanner: false,
    );
  }
}