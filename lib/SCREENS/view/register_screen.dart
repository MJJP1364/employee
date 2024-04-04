import 'package:employee_attendance/SCREENS/controller/auth_controller.dart';
import 'package:employee_attendance/WIDGETS/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight / 4,
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(70),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner, color: Colors.white, size: 80),
                  SizedBox(height: 20),
                  Text(
                    'SIG Group',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),

            // email ----------------------
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  InputText(
                    controller: controller.emailController,
                    hidePassword: false,
                    hintText: 'Employee Email ID',
                    icon: Icons.person,
                    lable: 'Email',
                  ),

                  const SizedBox(height: 15),

                  // password ----------------
                  InputText(
                    controller: controller.passwordController,
                    hidePassword: true,
                    hintText: 'Enter Password',
                    icon: Icons.lock,
                    lable: 'Password',
                  ),

                  const SizedBox(height: 25),

                  Obx(() {
                    return controller.signupLoading.isTrue
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => controller.regidterAccount(
                                  '${controller.emailController.text.trim()}@gmail.com',
                                  controller.passwordController.text.trim()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                              ),
                              child: const Text(
                                'REGISTER',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
