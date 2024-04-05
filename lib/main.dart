import 'dart:math';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Common/widgets/error.dart';
import 'package:whatsapp/Common/widgets/loder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp/feature/auth/controller/authController.dart';
import 'package:whatsapp/feature/landing_screen/landing_screen.dart';
import 'package:whatsapp/responsive/mobile_screen_layout.dart';
import 'package:whatsapp/responsive/responsive_layout.dart';
import 'package:whatsapp/responsive/web_screen_layout.dart';
import 'package:whatsapp/router.dart';
import 'package:whatsapp/theme/themeing.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //apna app paly store me release krne ke liye ..... we use App check ...
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      theme: Themeing().getLightTheme(),
      darkTheme: Themeing().getDarkTheme(),
      themeMode: ThemeMode.system, // default
      onGenerateRoute: (settings) => generateRoute(settings),
      // Persisting the state
      home:
      ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) {
              return const LandingScreen();
            }
            return const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            );
          },
          error: (error, stackTrace) {
            print(error.toString());
            return ErrorScreen(error: error.toString());
          },
          loading: () => const LoderScreen()),
    );
  }
}