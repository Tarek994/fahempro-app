import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fahem/core/network/firebase_constants.dart';
import 'package:fahem/core/resources/constants_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  static final FirebaseMessaging _instance = FirebaseMessaging.instance;
  static const String _serverKey = 'AAAANI-vLJs:APA91bEoTs6yBH_pHTTrVlNaWaBOocEU0bdk4dFML-zIte4azpuUAO688dkPbxrmhVqhELUQl8vpg6RAwki-w1pTkExHC6Gu4N0QlnPjvadQWE-RbbxPrnsMlPFM2dyjfq_gilZw1c0W	';

  static Future<void> init() async {
    await _initAwesomeNotifications();
    await _requestPermissionFirebaseMessaging();
    _whenTheAppIsOpen();
    _whenTheAppIsClosed();
    _whenClickOnNotificationAndAppIsInBackground();
    _whenClickOnNotificationAndAppIsInTerminate();
  }

  static Future<void> _initAwesomeNotifications() async {
    List<NotificationChannel> channels = [
      NotificationChannel(
        channelKey: 'CHANNEL_KEY',
        channelName: 'CHANNEL_NAME',
        channelDescription: 'CHANNEL_DESCRIPTION',
        playSound: true,
        channelShowBadge: true,
        importance: NotificationImportance.High,
        // soundSource: 'resource://raw/SOUND_NAME',
      ),
    ];
    await AwesomeNotifications().initialize(null, channels);
    _requestPermissionAwesomeNotifications();
  }

  static Future<void> _requestPermissionAwesomeNotifications() async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  static Future<void> createLocalNotification({required String title, required String body, DateTime? scheduleDateTime}) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'CHANNEL_KEY',
        title: title,
        body: body,
      ),
      schedule: scheduleDateTime == null ? null : NotificationCalendar.fromDate(date: scheduleDateTime),
    );
  }

  static Future<void> _requestPermissionFirebaseMessaging() async {
    await _instance.requestPermission();
  }

  static void _onClickNotification(Map<String, dynamic> data) async {
    // print(data);
    if (data['action'] == FirebaseConstants.newComplaint) {
      ConstantsManager.navigatorKey.currentState?.pushNamed(Routes.complaintsScreen);
    }
    if (data['action'] == FirebaseConstants.newJob) {
      ConstantsManager.navigatorKey.currentState?.pushNamed(Routes.jobsScreen);
    }
    if (data['action'] == FirebaseConstants.editJob) {
      ConstantsManager.navigatorKey.currentState?.pushNamed(Routes.jobsScreen);
    }
  }

  // static bool _checkInSameScreenOrNot() {
  //   bool isNewRouteSameAsCurrent = false;
  //   ConstantsManager.navigatorKey.currentState?.popUntil((route) {
  //     if(route.settings.name == Routes.complaintsScreen) {
  //       isNewRouteSameAsCurrent = true;
  //     }
  //     return true;
  //   });
  //   return isNewRouteSameAsCurrent;
  // }

  // Execute This Method When App Is Open (Foreground)
  static Future<void> _whenTheAppIsOpen() async {
    FirebaseMessaging.onMessage.listen((remoteMessage) async {
      debugPrint('_whenAppIsOpen');
      // if(_checkInSameScreenOrNot()) return;
      createLocalNotification(title: remoteMessage.notification!.title ?? '', body: remoteMessage.notification!.body ?? '');
      // _onClickNotification(remoteMessage.data);
    });
  }

  // Firebase Messaging Background Handler
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
    debugPrint('_firebaseMessagingBackgroundHandler');
  }

  // Execute This Method When App Is Close (Background & Terminate) - Must Calling This Method Before runApp
  static Future<void> _whenTheAppIsClosed() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Execute This Method When Click On Notification And App Is In Background
  static Future<void> _whenClickOnNotificationAndAppIsInBackground() async {
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      debugPrint('_whenClickOnNotificationAndAppIsInBackground');
      _onClickNotification(remoteMessage.data);
    });
  }

  // Execute This Method When Click On Notification And App Is In Terminate
  static Future<void> _whenClickOnNotificationAndAppIsInTerminate() async {
    _instance.getInitialMessage().then((remoteMessage) {
      if(remoteMessage != null) {
        debugPrint('_whenClickOnNotificationAndAppIsInTerminate');
        _onClickNotification(remoteMessage.data);
      }
    });
  }

  // Get Device Token For App In Device
  static Future<String?> getToken() async {
    return await _instance.getToken();
  }

  // Subscribe To Topic
  static Future<void> subscribeToTopic(String topic) async {
    await _instance.subscribeToTopic(topic);
  }

  // Unsubscribe From Topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _instance.unsubscribeFromTopic(topic);
  }

  // Push Notification
  static Future<void> pushNotification({required String topic, required String title, required String body, Map<String, dynamic>? data}) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=$_serverKey",
        },
        body: jsonEncode({
          "to": "/topics/$topic",
          "notification": {
            "title": title,
            "body": body,
          },
          "priority": "HIGH",
          "data": data
        }),
      );
    }
    catch(error) {
      debugPrint("Error Push Notification: ${error.toString()}");
    }
  }
}