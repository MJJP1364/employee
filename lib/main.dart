import 'package:employee_attendance/SCREENS/controller/auth_controller.dart';
import 'package:employee_attendance/SCREENS/view/home_screen.dart';
import 'package:employee_attendance/SCREENS/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabasekEY = dotenv.env['SUPABASE_KEY'] ?? '';
  Supabase.initialize(url: supabaseUrl, anonKey: supabasekEY);
  runApp(const MyApp());
}

// salam
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Attendance',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: controller.currentUser == null
          ? const LoginScreen()
          : const HomeScreen(),
    );
  }
}
