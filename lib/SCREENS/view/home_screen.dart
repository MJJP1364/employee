import 'package:employee_attendance/SCREENS/controller/auth_controller.dart';
import 'package:employee_attendance/SCREENS/view/attendance_screen.dart';
import 'package:employee_attendance/SCREENS/view/calender_screen.dart';
import 'package:employee_attendance/SCREENS/view/profile_screen.dart';
import 'package:employee_attendance/WIDGETS/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // final controller = Get.put(AuthController());
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: AuthController.instance.currentIndex.value,
          children: const [
            CalenderScreen(),
            AttandanceScreen(),
            ProfileScreen(),
          ],
        );
      }),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
