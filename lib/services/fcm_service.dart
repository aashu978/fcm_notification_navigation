import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import '../config/router.dart';

// Global holder for the device FCM token
String? fcmToken;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Setup FCM Service
/// 
/// What this does:
/// 1. Requests notification permissions (important for iOS)
/// 2. Gets device token for testing
/// 3. Listens for foreground messages
/// 4. Handles background messages
/// 5. Handles notification clicks
/// 6. Checks for initial message (terminated state)
Future<void> setupFCMService() async {
  debugPrint('🔔 Setting up FCM service...');
  
  final messaging = FirebaseMessaging.instance;
  
  // Create notification channel for Android
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Initialize local notifications
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      final payload = response.payload;
      if (payload != null && payload.isNotEmpty) {
        try {
          final Map<String, dynamic> data = jsonDecode(payload);
          _handleNotificationClick(RemoteMessage(data: data));
        } catch (e) {
          debugPrint('Error parsing notification payload: $e');
        }
      }
    },
  );

  // Request notification permissions (iOS requires this)
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  debugPrint('User notification permission: ${settings.authorizationStatus}');

  // Get device token
  final token = await messaging.getToken();
  // Store token globally for UI access
  fcmToken = token;
  debugPrint('🎫 Device FCM Token: $token');
  debugPrint('⚠️  Copy this token to test notifications!');

  // Listen for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('📬 Got a message in foreground: ${message.messageId}');
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Body: ${message.notification?.body}');
    debugPrint('Data: ${message.data}');
    
    _showLocalNotification(message);
  });

  // Listen for background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Handle notification clicks (app in background)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('💬 Message clicked: ${message.messageId}');
    _handleNotificationClick(message);
  });

  // Check if app was opened from notification (terminated state)
  RemoteMessage? initialMessage =
      await messaging.getInitialMessage();
  if (initialMessage != null) {
    debugPrint('📲 App opened from notification (terminated): ${initialMessage.messageId}');
    _handleNotificationClick(initialMessage);
  }

  debugPrint('✅ FCM service setup complete');
}

/// Show local notification for foreground messages
void _showLocalNotification(RemoteMessage message) {
  flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.notification?.title ?? 'Notification',
    message.notification?.body ?? '',
    NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'Notifications for tasks and flags',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
    payload: jsonEncode(message.data),
  );
}

/// Handle notification click and navigate
void _handleNotificationClick(RemoteMessage message) {
  final deepLink = message.data['deepLink'];
  debugPrint('🔗 Deep link from notification: $deepLink');
  
  if (deepLink != null && deepLink is String && deepLink.isNotEmpty) {
    debugPrint('✅ Navigating to: $deepLink');
    getRouter().go(deepLink);
  }
}

/// Background message handler (top-level function required)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('🔔 Handling background message: ${message.messageId}');
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
}