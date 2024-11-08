// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

//   Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await _notificationsPlugin.initialize(initializationSettings);
//     tz.initializeTimeZones(); 
//   }

//   Future<void> scheduleNotification(int id, DateTime dateTime, String message) async {
//     await _notificationsPlugin.zonedSchedule(
//       id,
//       'Task Reminder',
//       message,
//       tz.TZDateTime.from(dateTime, tz.local),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'your_channel_id',
//           'Your Channel Name',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
//     );
//   }
// }
