import 'package:flutter/material.dart';
import 'package:second_app/core/strings/app_string.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppString.calls),
      ),
    );
  }
}
