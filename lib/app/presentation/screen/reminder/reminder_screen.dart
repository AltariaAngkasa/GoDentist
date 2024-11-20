import 'package:flutter/material.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengingat"),
      ),
      body: Center(
        child: Text("Coming Soon...", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
