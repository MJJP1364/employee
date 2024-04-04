import 'dart:math';

import 'package:employee_attendance/CONSTANTS/constants.dart';
import 'package:employee_attendance/MODELS/user_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService extends GetxController {
  static DBService get instance => Get.find();
  final SupabaseClient supabase = Supabase.instance.client;
  UserModel? userModel;

  // RxBool isLoading = false.obs;

  String generateRandomEmployeeID() {
    final random = Random();
    const allChars = 'sigSIG0123456789';
    final randomString =
        List.generate(8, (index) => allChars[random.nextInt(allChars.length)])
            .join();
    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await supabase.from(Constants.employeeTable).insert({
      'id': id,
      'name': '',
      'email': email,
      'employee_id': generateRandomEmployeeID(),
      'department': null,
    });
  }

  Future<UserModel> getUserData() async {
    final userData = await supabase
        .from(Constants.employeeTable)
        .select()
        .eq('id', supabase.auth.currentUser!.id)
        .single();
    userModel = UserModel.fromJson(userData);
    return userModel!;
  }
}
