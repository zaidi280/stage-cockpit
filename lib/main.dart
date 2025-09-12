import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/Dashboard.view.dart';
import 'package:flutter_application_1/view/Notifaction.view.dart';
import 'package:flutter_application_1/view/aquisition.view.dart';
import 'package:flutter_application_1/view/login.view.dart';
import 'package:flutter_application_1/view/signup.view.dart';
import 'package:flutter_application_1/view/splash.view.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  FirebaseMessaging.instance.getToken().then((token) {
      
      print("Firebase Messaging Token: $token");
    });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashView()),
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/signup', page: () => SignupView()),
        GetPage(name: '/dashboard', page: () => const DashboardView()),
        GetPage(name: '/acquisition', page: () => AcquisitionPage()),
        GetPage(name: '/temporelle', page: () => AcquisitionPage()),
        GetPage(name: '/notifications', page: () => const NotificationView()),
      ],
    );
  }
}
