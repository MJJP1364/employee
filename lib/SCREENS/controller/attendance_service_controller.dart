import 'package:employee_attendance/CONSTANTS/constants.dart';
import 'package:employee_attendance/MODELS/attendance_model.dart';
import 'package:employee_attendance/WIDGETS/get_snackbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'db_service_controller.dart';

class AttendanceService extends GetxController {
  static AttendanceService get instance => Get.find();

  final SupabaseClient supabase = Supabase.instance.client;
  AttendanceModel? attendance;

  final dbController = Get.put(DBService());

  String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  RxBool isLoading = false.obs;
  bool checkState = false;

  @override
  void onInit() {
    getTodayAttendence();
    super.onInit();
  }

  Future getTodayAttendence() async {
    final List result = await supabase
        .from(Constants.attendanceTable)
        .select()
        .eq('employee_id', supabase.auth.currentUser!.id)
        .eq('date', todayDate);
    if (result.isNotEmpty) {
      attendance = AttendanceModel.fromJson(result.first);
    }
    update();
  }

  Future markAttendance(BuildContext context) async {
    if (attendance?.checkIn == null) {
      await supabase.from(Constants.attendanceTable).insert({
        'id': supabase.auth.currentUser!.id,
        'employee_id': supabase.auth.currentUser!.id,
        'date': todayDate,
        'check_in': DateFormat('HH:mm').format(DateTime.now()),
      });
      TLoaders.successSnackBar(title: 'You have already checked in !');
    } else if (attendance?.checkOut == null) {
      await supabase
          .from(Constants.attendanceTable)
          .update({
            'check_out': DateFormat('HH:mm').format(DateTime.now()),
          })
          .eq('employee_id', supabase.auth.currentUser!.id)
          .eq('date', todayDate);
      TLoaders.warningSnackBar(title: 'You have already checked out !');
    } else {
      TLoaders.customToast(message: 'You are Checked Out for today ');
    }

    checkState = !checkState;
    getTodayAttendence();
    update();
  }
}
