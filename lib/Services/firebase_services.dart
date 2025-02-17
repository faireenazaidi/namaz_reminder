import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'notification_service.dart';

class FirebaseMessagingService {
  // Singleton setup
  static final FirebaseMessagingService _instance = FirebaseMessagingService._internal();
  factory FirebaseMessagingService() => _instance;
  FirebaseMessagingService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken;

  /// Initialize Firebase Messaging and setup notifications
  Future<void> initializeFirebaseMessaging() async {
    await AwesomeNotificationService().initialize();
    // await _initializeAwesomeNotifications();  // Initialize Awesome Notifications
    await _requestPermissions();

    // Get and store the Firebase token
    _fcmToken = await _firebaseMessaging.getToken();
    print('Firebase Messaging Token: $_fcmToken');

    // Listen for token refreshes and handle accordingly
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      print('New Firebase Messaging Token: $newToken');
      // You can send the new token to the server if needed
    });

    // Handle foreground messages (when the app is open)
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle messages when the app is opened from the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Handle messages that caused the app to open from a terminated state
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }

    // Handle background message processing (background execution)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Initialize Awesome Notifications
  Future<void> _initializeAwesomeNotifications() async {
    AwesomeNotifications().initialize(
      null, // Use the default app icon
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
        ),
        NotificationChannel(
          channelKey: 'big_picture',
          channelName: 'Big Picture notifications',
          channelDescription: 'Notification channel for big picture tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
      ],
      debug: true,
    );
  }

  /// Request notification permissions for iOS
  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  /// Get the current token
  String? getToken() => _fcmToken;

  /// Handle foreground messages and show Awesome Notifications
  void _handleForegroundMessage(RemoteMessage message) {
    if (message.notification != null) {
      print('Received message in foreground: ${message.notification?.title}');
      // Determine notification type and channel
      String channelKey = _getChannelKeyFromMessage(message);

      // Show notification with the appropriate sound
      AwesomeNotificationService().showNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        channelKey: channelKey,
      );
      // _showAwesomeNotification(message.notification?.title, message.notification?.body);
    }
  }

  /// Handle background/terminated messages when the app is opened via a notification
  void _handleMessageOpenedApp(RemoteMessage message) {
    if (message.notification != null) {
      print('Opened message from background/terminated state: ${message.notification?.title}');
      // You can navigate to a specific screen or handle custom actions
    }
  }

  /// Background handler for messages received while the app is not running
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling background message: ${message.notification?.title}');
    // Determine notification type and channel
    // String channelKey = _getChannelKeyFromMessage(message);
    //
    // // Show notification
    // await AwesomeNotificationService().showNotification(
    //   title: message.notification?.title,
    //   body: message.notification?.body,
    //   channelKey: channelKey,
    // );
    // Handle background notification logic here
  }
  /// Helper method to determine channel key from message data
  static String _getChannelKeyFromMessage(RemoteMessage message) {
    String channelKey = 'basic_channel'; // Default channel

    if (message.data.containsKey('type')) {
      switch (message.data['type']) {
        case 'important':
          channelKey = 'important_channel';
          break;
        case 'urgent':
          channelKey = 'urgent_channel';
          break;
        default:
          channelKey = 'basic_channel';
          break;
      }
    }

    return channelKey;
  }
}

