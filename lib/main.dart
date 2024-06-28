/// Sports chat app
/// Github username: Mugamba669
/// Name: Mugamba Bruno
/// Date: 03/11/2023

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fau/controllers/league_controller.dart';
import 'package:flutter/services.dart';
import '/services/device_manager.dart';
import '/services/fixture_service.dart';
// import '/test.dart';
import '/theme/Theme.dart';

import '/exports/exports.dart';
import 'controllers/fixture_controller.dart';
import 'firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services
  debugPrint('Handling a background message ${message}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  // IOSFlutterLocalNotificationsPlugin()
  //     .requestPermissions(alert: true, badge: true, sound: true);
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
// NotificationChannel()
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  AppleNotification? ios = message.notification?.apple;
  if (notification != null && android != null && ios != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
          priority: Priority.high,
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          subtitle: notification.body,
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
void setUpMessage() {
  FirebaseMessaging.instance.getInitialMessage().asStream().listen((message) {
    if (message != null) {
      if (message.data["type"] == "fixture") {
        FixtureService.getFixtures(leagueId).asStream().listen((fixtures) {
          var fixture = fixtures
              .where((element) => element.id == message.data["data"])
              .first;
          Routes.animateToPage(
            TeamsPage(
              data: fixture,
            ),
          );
        });
      }
    }
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // log("On message event.");
    // debugPrint(message.data.toString());
    if (message.data["type"] == "fixture") {
      FixtureService.getFixtures(leagueId).asStream().listen((fixtures) {
        var fixture = fixtures
            .where((element) => element.id == message.data["data"])
            .first;
        Routes.animateToPage(
          TeamsPage(
            data: fixture,
          ),
        );
      });
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // log("Message opened app");
    // debugPrint(message.data.toString());
    // working on match rooms when notification opens the app
    if (message.data["type"] == "fixture") {
      FixtureService.getFixtures(leagueId).asStream().listen((fixtures) {
        var fixture = fixtures
            .where((element) => element.id == message.data["data"])
            .first;
        Routes.animateToPage(
          TeamsPage(
            data: fixture,
          ),
        );
      });
    }
  });
}

// get token after retry
Future<String?> getTokenWithRetry({int maxAttempts = 3}) async {
  for (int attempt = 1; attempt <= maxAttempts; attempt++) {
    try {
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.getAPNSToken();
      }
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      if (e is FirebaseException && e.code == 'service-not-available') {
        if (attempt == maxAttempts) {
          print('Failed to retrieve FCM token after $maxAttempts attempts');
          return null;
        }
        // Wait before retrying, with exponential backoff
        await Future.delayed(Duration(seconds: 2 * attempt));
      } else {
        rethrow; // For other exceptions, rethrow
      }
    }
  }
  return null;
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  // Ensuring that all widgets are properly assembled.
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      await setupFlutterNotifications();
    }

    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    setUpMessage();
  } catch (e) {
    log(e.toString());
  }
  // await DeviceManager.clearAll();
  // Rendering the app in full screen mode.
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [],
  );
  // prevent app from changing to landscape
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
// styling to the top and bottom navigation bars in full screen mode.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black12,
    ),
  );
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // DeviceManager.clearAll();
    DeviceManager.checkDeviceId().asStream().listen((event) {
      // if (event) {
      //   FirebaseMessaging.instance.getAPNSToken().asStream().listen((apn) {
      //     FirebaseMessaging.instance.getToken().asStream().listen((token) {
      //       if (token != null) {
      //         DeviceManager.saveDeviceKey(
      //             token, "${iosInfo.model}_${iosInfo.identifierForVendor}");
      //       }
      //     });
      //   });
      // }
    });
  } else {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // DeviceManager.clearAll();
    DeviceManager.checkDeviceId().asStream().listen((event) {
      if (event) {
        // FirebaseMessaging.instance.getToken().asStream().listen((token) {
        getTokenWithRetry().asStream().listen((token) {
          if (token != null) {
            DeviceManager.saveDeviceKey(
                token, "${androidInfo.model}_${androidInfo.fingerprint}");
          }
        });
      }
    });
  }
// bool.fromEnvironment("dart.vm.product");
  // main entry point for the app.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataController(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayerController(),
        ),
        ChangeNotifierProvider(
          create: (context) => StatsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FixtureController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LeagueController(),
        ),
      ],
      child: Consumer<AppController>(
        builder: (context, controller, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            initialRoute: Routes.splash,
            debugShowCheckedModeBanner: false,
            routes: Routes.routes,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            themeMode: controller.appTheme == 3
                ? ThemeMode.system
                : controller.appTheme == 2
                    ? ThemeMode.dark
                    : ThemeMode.light,
          );
        },
      ),
    ),
  );
}
