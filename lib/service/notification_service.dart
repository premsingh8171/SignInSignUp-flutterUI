import 'dart:io';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled1/dashboard/message_screen.dart';

/// A service class to handle notifications using Firebase Cloud Messaging and local notifications.
class NotificationService {
  // Instance of FlutterLocalNotificationsPlugin for managing local notifications.
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Instance of FirebaseMessaging for handling Firebase messaging.
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Requests notification permissions from the user.
  Future<void> requestNotificationPermission() async {
    // Requesting permission for notifications.
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    // Handling the user's response to the permission request.
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User  granted permission");
    } else {
      print("User  declined or has not accepted permission");
    }
  }

  // Initializes local notifications and sets up the notification response handler.
  Future<void> initLocalNotification(BuildContext context, RemoteMessage message) async {
    // Android initialization settings for local notifications.
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    // iOS initialization settings for local notifications.
    var iosInitializationSettings = const DarwinInitializationSettings();

    // Combine Android and iOS settings into one initialization settings object.
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    // Initialize the local notifications plugin.
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          print("Notification payload: $payload");
          handleMessage(context, message);
        });
  }

  // Initializes Firebase and sets up message handling.
  Future<void> firebaseInit(BuildContext context) async {
    // Initialize Firebase.
    await Firebase.initializeApp();

    // Handle messages when the app is terminated.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("Terminated Notification: ${initialMessage.notification?.title}");
      // Handle the initial message if needed.
    }

    // Handle foreground messages.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground Notification: ${message.notification?.title}");
      print("Foreground Notification: ${message.notification?.body}");
      print("${message.data.toString()}");
      // Show the notification when a message is received.
      if(Platform.isAndroid){
        initLocalNotification(context, message);
        showNotification(message);
      }else{
        showNotification(message);

      }
    });
  }

  // Displays a local notification based on the received message.
  Future<void> showNotification(RemoteMessage message) async {
    // Create a unique notification channel for Android.
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance Notifications',
      importance: Importance.max,
    );

    // Android-specific notification details.
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    // iOS-specific notification details.
    final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Combine Android and iOS notification details.
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinNotificationDetails,
    );

    // Show the notification.
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  // Retrieves the device token for Firebase Cloud Messaging.
  Future<String> getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token!;
  }

  // Listens for token refresh events.
  void isTokenRefresh() async {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      print('Token refreshed: $event');
    });
  }

  Future<void>  setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage!=null){
      handleMessage(context, initialMessage);
    }

    //when app  is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event){
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print(message.data.toString());
    if (message.data['type'] == 'psd') {
      String messageId = message.data['id'] ?? ""; // Get the message ID or default to an empty string
      print("coming -- $messageId");
    }
    String messageId = message.data['id'] ?? ""; // Get the message ID
    Navigator.of(context).pushNamed('/notification', arguments: messageId);
  }

}






















/*
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging=
      FirebaseMessaging.instance;

 */
/* @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
    //await Firebase.initializeApp(options:DefautFirebaseOptions.currentPlatform,);
    print("Handling a background message: ${message.messageId}");

  }*//*


  void requestNotificationPermission() async{
  NotificationSettings settings=await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );

  if(settings.authorizationStatus==AuthorizationStatus.authorized){
    print("User granted permission");
  }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
      print("User declined or has not accepted permission");
  }else{
      print("User declined or has not accepted permission");
  }
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =  const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          print(payload);
        });

  }


  Future<void> initFirebase() async {
    await Firebase.initializeApp();
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle terminated state messages
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("Terminated Notification: ${initialMessage.notification?.title}");
      // Handle the initial message
    }

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground Notification: ${message.notification?.title}");
      // Handle the message
    });

    //
    FirebaseMessaging.onMessage.listen((message){
      if(kDebugMode){
        print(" Notification: ${message.notification?.title}");
        print(" Notification: ${message.notification?.body}");
      }
      showNotification(message);

    });
  }

  Future<void> showNotification(RemoteMessage message)  async{
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance Notifications',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true
        );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, (){
      _flutterLocalNotificationsPlugin.show(
          0, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });

  }

  Future<String> getDeviceToken() async{
    String? token= await _firebaseMessaging.getToken();
    return token!;
  }

  void isTokenRefresh()async{
    _firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
      print('Refresh');
    });
  }


}*/
