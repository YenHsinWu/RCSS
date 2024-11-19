import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          '收到訊息：${message.notification?.title}, ${message.notification?.body}');
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('從推播通知啟動APP：${message.notification?.title}');
    });

    String? token = await _firebaseMessaging.getToken();
  }

  Future<void> _showNotification(RemoteMessage message) async {
    final notification = message.notification;

    if (notification != null) {
      await _flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'default channel', 'default channel',
              channelDescription: 'This is the default channel',
              importance: Importance.high,
              priority: Priority.high),
        ),
      );
    }
  }
}
