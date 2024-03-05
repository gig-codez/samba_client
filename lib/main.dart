/// Sports chat app
/// Github username: Mugamba669
/// Name: Mugamba Bruno
/// Date: 03/11/2023

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import '/services/device_manager.dart';
import '/services/fixture_service.dart';
// import '/test.dart';
import '/theme/Theme.dart';

import '/exports/exports.dart';
import 'controllers/PlayerController.dart';
import 'controllers/data_controller.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Working example of FirebaseMessaging.
/// Please use this in order to verify messages are working in foreground, background & terminated state.
/// Setup your app following this guide:
/// https://firebase.google.com/docs/cloud-messaging/flutter/client#platform-specific_setup_and_requirements):
///
/// Once you've completed platform specific requirements, follow these instructions:
/// 1. Install melos tool by running `flutter pub global activate melos`.
/// 2. Run `melos bootstrap` in FlutterFire project.
/// 3. In your terminal, root to ./packages/firebase_messaging/firebase_messaging/example directory.
/// 4. Run `flutterfire configure` in the example/ directory to setup your app with your Firebase project.
/// 5. Open `token_monitor.dart` and change `vapidKey` to yours.
/// 6. Run the app on an actual device for iOS, android is fine to run on an emulator.
/// 7. Use the following script to send a message to your device: scripts/send-message.js. To run this script,
///    you will need nodejs installed on your computer. Then the following:
///     a. Download a service account key (JSON file) from your Firebase console, rename it to "google-services.json" and add to the example/scripts directory.
///     b. Ensure your device/emulator is running, and run the FirebaseMessaging example app using `flutter run`.
///     c. Copy the token that is printed in the console and paste it here: https://github.com/firebase/flutterfire/blob/01b4d357e1/packages/firebase_messaging/firebase_messaging/example/lib/main.dart#L32
///     c. From your terminal, root to example/scripts directory & run `npm install`.
///     d. Run `npm run send-message` in the example/scripts directory and your app will receive messages in any state; foreground, background, terminated.
///  Note: Flutter API documentation for receiving messages: https://firebase.google.com/docs/cloud-messaging/flutter/receive
///  Note: If you find your messages have stopped arriving, it is extremely likely they are being throttled by the platform. iOS in particular
///  are aggressive with their throttling policy.
///
/// To verify that your messages are being received, you ought to see a notification appearon your device/emulator via the flutter_local_notifications plugin.
/// Define a top-level named handler which background/terminated messages will
/// call. Be sure to annotate the handler with `@pragma('vm:entry-point')` above the function declaration.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
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

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  // Ensuring that all widgets are properly assembled.
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

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
  // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, badge: true, sound: true);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  setUpMessage();
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
      if (event) {
        FirebaseMessaging.instance.getAPNSToken().asStream().listen((apn) {
          FirebaseMessaging.instance.getToken().asStream().listen((token) {
            if (token != null) {
              DeviceManager.saveDeviceKey(
                  token, "${iosInfo.model}_${iosInfo.identifierForVendor}");
            }
          });
        });
      }
    });
  } else {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // DeviceManager.clearAll();
    DeviceManager.checkDeviceId().asStream().listen((event) {
      if (event) {
        FirebaseMessaging.instance.getToken().asStream().listen((token) {
          DeviceManager.saveDeviceKey(
              token!, "${androidInfo.model}_${androidInfo.fingerprint}");
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
      ],
      child: Consumer<AppController>(
        builder: (context, controller, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            initialRoute: Routes.splash,
            routes: Routes.routes,
            theme: controller.isDarkMode ? Themes.darkTheme : Themes.lightTheme,
          );
        },
      ),
    ),
  );
}
