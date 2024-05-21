import 'package:flutter/material.dart';
import 'package:location_reminder_app/utils/common_widgets.dart';

import '../services/notification_services.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final NotificationService notificationService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Map Screen'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonButton(
                title: "Toast Message",
                onTap: () {
                  commonToast(message: "Check Toast Message");
                },
                backgroundColor: Colors.black26,
              ),
              commonButton(
                title: "Notification",
                onTap: () {
                  notificationService.showNotification(
                    0,
                    'Test Notification',
                    'This is the body of the test notification.',
                  );
                },
                backgroundColor: Colors.black26,
              ),
            ],
          ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }
}
