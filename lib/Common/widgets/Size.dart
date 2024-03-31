import 'package:flutter/material.dart';

class Size extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;
  
  const Size({Key? key, required this.height, required this.width, this.widget = const SizedBox()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: widget, 
      ),
    );
  }
}
