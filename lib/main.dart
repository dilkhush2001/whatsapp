import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whatsapp/Common/utils/utils.dart';
import 'package:whatsapp/Common/widgets/CustomButton.dart';
import 'package:whatsapp/Common/widgets/error.dart';
import 'package:whatsapp/Common/widgets/loder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  return runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ErrorScreen(error: "fghjk"),
    );
  }
}
