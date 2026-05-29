import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Clipboard
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import '../../services/fcm_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _token = fcmToken;
  }

  void _copyToken() {
    if (_token != null && _token!.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _token!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('FCM token copied to clipboard')),
      );
    }
  }

  void _triggerTestNotification(String deepLink) {
    flutterLocalNotificationsPlugin.show(
      deepLink.hashCode,
      'Test Navigation',
      'Tap to navigate to: $deepLink',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription: 'Notifications for testing',
          importance: Importance.high,
          priority: Priority.high,
          showWhen: true,
          enableVibration: true,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode({'deepLink': deepLink}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 100),
              const SizedBox(height: 20),
              const Text('Your Profile', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Text(
                _token ?? 'FCM Token not available',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _copyToken,
                icon: const Icon(Icons.copy),
                label: const Text('Copy Token'),
              ),
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 20),
              const Text(
                'Test Notification Navigation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap a button below to trigger a local notification. Tapping that notification will test deep link navigation.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _triggerTestNotification('/'),
                    child: const Text('Home (/)'),
                  ),
                  ElevatedButton(
                    onPressed: () => _triggerTestNotification('/task/task_001'),
                    child: const Text('Task Details (/task/task_001)'),
                  ),
                  ElevatedButton(
                    onPressed: () => _triggerTestNotification('/flag'),
                    child: const Text('Flags (/flag)'),
                  ),
                  ElevatedButton(
                    onPressed: () => _triggerTestNotification('/flag/flag_001'),
                    child: const Text('Flag Details (/flag/flag_001)'),
                  ),
                  ElevatedButton(
                    onPressed: () => _triggerTestNotification('/profile'),
                    child: const Text('Profile (/profile)'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
