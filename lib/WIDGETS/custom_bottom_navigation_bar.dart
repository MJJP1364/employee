import 'package:employee_attendance/SCREENS/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<IconData> navigationIcons = [
      FontAwesomeIcons.solidCalendarDays,
      FontAwesomeIcons.check,
      FontAwesomeIcons.solidUser,
    ];
    final _controller = Get.put(AuthController());
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight / 11,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < navigationIcons.length; i++) ...{
            Obx(() {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    _controller.currentIndex.value = i;
                  },
                  child: Center(
                    child: FaIcon(
                      navigationIcons[i],
                      color: i == _controller.currentIndex.value
                          ? Colors.redAccent
                          : Colors.black54,
                      size: i == _controller.currentIndex.value ? 40 : 20,
                    ),
                  ),
                ),
              );
            })
          }
        ],
      ),
    );
  }
}
