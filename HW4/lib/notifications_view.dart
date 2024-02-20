import 'package:flutter/material.dart';
import 'package:hw_2/another_page.dart';
import 'package:hw_2/sensor_detection_view.dart';
import 'package:hw_2/notifications_class.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    listenToNotif();
    super.initState();
  }

  listenToNotif() {
    print("Listening to notification");
    NotificationObject.onClickNotification.stream.listen((event) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => AnotherPage(payload: event)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Press this button to activate a scheduled notification'),
              SizedBox(height: 24),
              FloatingActionButton(
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.notification_add_rounded),
                onPressed: () async {
                  await NotificationObject.showScheduleNotification(
                      title: 'Scheduled!',
                      body: 'Check this notification!',
                      payload: 'Thank you for using this application.');
                  final snackBar = SnackBar(
                    backgroundColor: Colors.blue,
                    content: Text('Scheduled notification activated.'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                // icon: ,
              ),
              SizedBox(height: 48),
              Text('Go to this page to test sensor detection'),
              SizedBox(height: 16),
              IconButton(
                  color: Colors.blue.shade100,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SensorDetectionView()));
                  },
                  icon: Icon(Icons.compass_calibration_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
