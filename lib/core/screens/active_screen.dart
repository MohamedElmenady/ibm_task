import 'package:flutter/material.dart';
import 'package:second_app/core/strings/app_string.dart';

class ActiveScreen extends StatelessWidget {
  const ActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppString.active),
      ),
    );
  }
}
