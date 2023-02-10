import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices{

  static String NotificationTitile = '';
  static String NotificationBody = '';
  static DateTime scheduleTime = DateTime.now().hour as DateTime;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings = const AndroidInitializationSettings('logo');

  void initializeNotifications() async{

    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleNotification(String NotificationTitile,String NotificationBody,int time) async{

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'channelIddd',
        'channelNameee',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );

    // await _flutterLocalNotificationsPlugin.show(0, 'title', 'body', notificationDetails);
    await _flutterLocalNotificationsPlugin.zonedSchedule(0, NotificationTitile, NotificationBody, tz.TZDateTime.now(tz.local).add(Duration(seconds: 10)), notificationDetails, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidAllowWhileIdle: true);
  }
}