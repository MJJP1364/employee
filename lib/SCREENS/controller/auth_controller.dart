import 'package:employee_attendance/SCREENS/view/home_screen.dart';
import 'package:employee_attendance/SCREENS/view/login_screen.dart';
import 'package:employee_attendance/SCREENS/controller/db_service_controller.dart';
import 'package:employee_attendance/WIDGETS/get_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  @override
  void onInit() {
    _getAuth();
    super.onInit();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final SupabaseClient supabase = Supabase.instance.client;
  final dbServise = Get.put(DBService());

  // Variables
  RxBool signinLoading = false.obs;
  RxBool signupLoading = false.obs;
  RxInt currentIndex = 1.obs;

  // signup
  Future regidterAccount(String email, String password) async {
    try {
      signupLoading.value = true;
      if (email == '' || password == '') {
        throw 'all fields are required';
      }
      final respons =
          await supabase.auth.signUp(email: email, password: password);

      // ignore: unnecessary_null_comparison
      if (respons != null) {
        await dbServise.insertNewUser(email, respons.user!.id);
        TLoaders.successSnackBar(
            title: 'Successfully registered !',
            message: 'Send verification Email to you');
        await loginAccount(email, password);
      }
    } catch (e) {
      signupLoading.value = false;
      TLoaders.errorSnackBar(title: e.toString());
    }
  }

  // login
  Future loginAccount( String email, String password) async {
    try {
      signinLoading.value = true;
      if (email == '' || password == '') {
        throw 'all fields are required';
      }
      await supabase.auth.signInWithPassword(email: email, password: password);
      TLoaders.successSnackBar(title: 'Success ! you are now loged in');
      Get.offAll(() => const HomeScreen(),
          duration: const Duration(milliseconds: 1500),
          transition: Transition.downToUp);
      signinLoading.value = false;
    } catch (e) {
      signinLoading.value = false;
      TLoaders.errorSnackBar(title: e.toString());
    }
  }

  Future signOut() async {
    await supabase.auth.signOut();
    Get.offAll(() => const LoginScreen(),
        duration: const Duration(milliseconds: 1500),
        transition: Transition.fadeIn);
  }

  User? currentUser;

  Future<void> _getAuth() async {
    currentUser = supabase.auth.currentUser;
    supabase.auth.onAuthStateChange.listen((event) {
      currentUser = event.session?.user;
    });
  }
}
