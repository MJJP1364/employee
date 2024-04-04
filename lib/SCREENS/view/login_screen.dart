import 'package:employee_attendance/SCREENS/controller/auth_controller.dart';
import 'package:employee_attendance/SCREENS/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../WIDGETS/input_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight / 3,
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

                  Obx(
                    () {
                      return controller.signinLoading.isTrue
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => controller.loginAccount(
                                    '${controller.emailController.text.trim()}@gmail.com',
                                    controller.passwordController.text.trim()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            );
                    },
                  ),

                  const SizedBox(height: 25),

                  TextButton(
                    onPressed: () => Get.to(() => const RegisterScreen(),
                        transition: Transition.circularReveal,
                        duration: const Duration(milliseconds: 1500)),
                    child: const Text(
                      "Are you a new employee ? Register here",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
