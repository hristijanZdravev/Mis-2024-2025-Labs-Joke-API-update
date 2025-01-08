import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joke_api_update/screens/home.dart';
import 'package:joke_api_update/screens/jokes.dart';
import 'package:joke_api_update/screens/random_joke.dart';
import 'package:joke_api_update/screens/favorite_joke.dart';
import 'package:joke_api_update/services/notification_service.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  await NotificationService().initialize();

  // Schedule a daily notification at 10:00 AM
  // scheduleDailyNotificationAt(10, 0);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokes API 213255',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/random_joke': (context) => const RandomJokeScreen(),
        '/favorite_joke': (context) => FavoriteJokeScreen(),
      },
    );
  }
}
//
// void scheduleDailyNotificationAt(int hour, int minute) async {
//   final NotificationService notificationService = NotificationService();
//
//   // Get the current time in the local timezone
//   final now = tz.TZDateTime.now(tz.local);
//
//   // Determine the next trigger time
//   final nextTriggerTime = tz.TZDateTime(
//     tz.local,
//     now.year,
//     now.month,
//     now.day,
//     hour,
//     minute,
//   );
//
//   // Adjust to tomorrow if the time has already passed today
//   final scheduledTime =
//   nextTriggerTime.isBefore(now) ? nextTriggerTime.add(Duration(days: 1)) : nextTriggerTime;
//
//   // Schedule the notification
//   await notificationService.showDailyNotification(
//     1, // Unique notification ID
//     "Joke Reminder",
//     "Check your daily joke to start the day off right!!",
//     scheduledTime.difference(now),
//   );
// }
