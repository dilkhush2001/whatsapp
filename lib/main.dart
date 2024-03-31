import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whatsapp/Common/utils/utils.dart';
import 'package:whatsapp/Common/widgets/CustomButton.dart';
import 'package:whatsapp/Common/widgets/error.dart';
import 'package:whatsapp/Common/widgets/loder.dart';
void main() {
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
