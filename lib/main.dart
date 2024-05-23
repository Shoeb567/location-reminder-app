import 'package:flutter/material.dart';
import 'package:location_reminder_app/screens/splash_screen.dart';
import 'package:location_reminder_app/services/notification_services.dart';
import 'package:location_reminder_app/utils/color_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Innovura Technology Pvt Ltd',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              color: AppColor.gray1,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
            filled: false,
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.000001, color: AppColor.gray1, style: BorderStyle.none)),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(width: 0.000001, color: AppColor.veryDarkGray2, style: BorderStyle.none)),
            errorBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(width: 0.000001, color: AppColor.strongRed, style: BorderStyle.none)),
            focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.000001, color: AppColor.gray1, style: BorderStyle.none)),
            isCollapsed: true,
            errorStyle: TextStyle(
              color: AppColor.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
            labelStyle: TextStyle(
              color: AppColor.veryDarkGray2,
              fontSize: 18,
              height: 1.48,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )),
      ),
      home: const SplashScreen(),
    );
  }
}
