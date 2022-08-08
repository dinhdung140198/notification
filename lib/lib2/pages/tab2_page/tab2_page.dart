import 'package:flutter/material.dart';

class Tab2Page extends StatelessWidget {
  final String text;
  const Tab2Page({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
