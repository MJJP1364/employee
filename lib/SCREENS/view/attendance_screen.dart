import 'package:employee_attendance/MODELS/user_model.dart';
import 'package:employee_attendance/SCREENS/controller/attendance_service_controller.dart';
import 'package:employee_attendance/WIDGETS/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class AttandanceScreen extends StatelessWidget {
  const AttandanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.put(AttendanceService());
    final GlobalKey<SlideActionState> key = GlobalKey<SlideActionState>();
    return GetBuilder<AttendanceService>(
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 30, color: Colors.black54),
                  ),
                ),
                FutureBuilder(
                  future: AttendanceService.instance.dbController.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserModel user = snapshot.data!;
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.name != '' ? user.name : '#${user.employee_id}',
                          style: const TextStyle(fontSize: 25),
                        ),
                      );
                    }
                    return const CustumShimmer();
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: const Text(
                    "Today's Status",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 32),
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Check In',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 20)),
                            const SizedBox(
                              width: 80,
                              child: Divider(),
                            ),
                            Text(
                              attendanceController.attendance?.checkIn ??
                                  '--:--',
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Check Out',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 20)),
                            const SizedBox(
                              width: 80,
                              child: Divider(),
                            ),
                            Text(
                              attendanceController.attendance?.checkOut ??
                                  '--:--',
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('dd MMMM yyyy').format(DateTime.now()),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          DateFormat('hh:mm:ss a').format(DateTime.now()),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black54),
                        ),
                      );
                    }),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Builder(
                    builder: (context) {
                      return SlideAction(
                      
                        text: attendanceController.checkState
                            ? 'Slide to Check Out'
                            : 'Slide to Check In',
                        textStyle: const TextStyle(
                            fontSize: 18, color: Colors.black54),
                        outerColor: Colors.white,
                        innerColor: Colors.redAccent,
                        key: key,
                        onSubmit: () async {
                          attendanceController.markAttendance(context);
                          key.currentState!.reset();
                          return null;
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
