import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rick_morty_flutter/firebase_options.dart';

final Logger messagingLogger = Logger('PraxisFirebaseMessaging');

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  messagingLogger.fine("Handling a background message: ${message.messageId}");
}

@injectable
class RmFirebaseMessaging {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  void setupMessaging() async {
    setupLocalNotifications();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await iosNotificationPermissions();
    listenForMessages();
  }

  Future<void> iosNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      whenMessagingAuthorized();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      messagingLogger.fine('User granted provisional permission');
      whenMessagingAuthorized(); // TODO how do we handle this ?
    } else {
      messagingLogger.fine('User declined or has not accepted permission');
    }
  }

  void whenMessagingAuthorized() async {
    messaging
        .getToken(
            vapidKey:
                "BJPCVj0UQyIqSPWi25_vBmefW6VFJjXUQR45ZI8xylcfmrsCgWPW5go9JnWT6bmh-nqhOiWna6tC6Fg3SS0zif0")
        .then((value) {
      messagingLogger.fine(value);
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void listenForMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      messagingLogger.fine('Got a message whilst in the foreground!');
      messagingLogger.fine('Message data: ${message.data}');

      if (message.notification != null) {
        messagingLogger.fine(
            'Message also contained a notification: ${message.notification}');
      }

      showLocalNotification(message);
    });
  }

  void setupLocalNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void showLocalNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            iOS: iosNotificationDetails(apple),
            android: androidNotificationDetails(android),
          ));
    }
  }

  DarwinNotificationDetails iosNotificationDetails(AppleNotification? apple) {
    return DarwinNotificationDetails(
        sound: apple?.sound?.name, subtitle: apple?.subtitle);
  }

  AndroidNotificationDetails androidNotificationDetails(
      AndroidNotification? android) {
    return AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      icon: android?.smallIcon,
    );
  }
}
