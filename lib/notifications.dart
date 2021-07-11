// Notications
// Used for setting up notifications within the application
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  final channelId = 'moodNotifications';
  final channelName = 'Mood Notifications';
  final channelDescription = 'Notifications for mood calendary app';

  var _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationDetails _platformChannelInfo;
  var _notificationId = 0;

  void init() {
    // Android settings
    const AndroidInitializationSettings initializeSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');

    // iOS settings
    final initializeSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) {
        return null;
      }
    );

    final initializationSettings = InitializationSettings(
      android: initializeSettingsAndroid, 
      iOS: initializeSettingsIOS
    );

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );

    var androidChannelInfo = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      ticker: 'ticker',
    );

    var iosChannelInfo = IOSNotificationDetails();

    _platformChannelInfo = NotificationDetails(
      android: androidChannelInfo,
      iOS: iosChannelInfo,
    );
  }

  // Occurs when a user selects the notification on their device
  Future onSelectNotification(String payload) async {
    if(payload != null) {
      print('Notification payload: $payload');
    }
    // await Navigator.push(
    //   _context, 
    //   MaterialPageRoute<void>(builder: (context) => SelectMood())
    // );
  }

  // Creates a daily notification occurence 
  Future<void> setupDailyMoodReminder() async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      _notificationId++,
      "You haven't tracked your mood yet for today.",
      "Take a minute and record your day.", 
      _nextInstanceOfEightPM(), // set to happen at the next occurence determined by this function
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'dailyMoodNotifications',
          'Daily mood tracking',
          'Daily notification for reminding you to track your mood'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time
      );
 }

  // Gets the next instance of 8pm
  // Used for daily notification
  tz.TZDateTime _nextInstanceOfEightPM() {
    print(tz.local);
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 20);  // 8pm
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    // print("Now: $now | Scheduled Date: $scheduledDate");
    return scheduledDate;
  }
}


