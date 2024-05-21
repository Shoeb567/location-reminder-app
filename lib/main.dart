import 'package:flutter/material.dart';
import 'package:location_reminder_app/screens/splash_screen.dart';
import 'package:location_reminder_app/services/notification_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationService notificationService = NotificationService();
  notificationService.initialize();
  runApp( MyApp());

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
      ),
      home: const SplashScreen(),
    );
  }
}
