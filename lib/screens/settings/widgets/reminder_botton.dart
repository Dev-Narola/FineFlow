import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:flutter/material.dart';

class ReminderBotton extends StatefulWidget {
  final String content;
  const ReminderBotton({
    super.key,
    required this.content,
  });

  @override
  State<ReminderBotton> createState() => _ReminderBottonState();
}

class _ReminderBottonState extends State<ReminderBotton> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(
          text: "Daily Reminder",
          fontSize: 16,
        ),
        Transform.scale(
          scale: 0.85,
          child: Switch(
              inactiveThumbColor: Kwhite,
              inactiveTrackColor: Kdark,
              activeTrackColor: Kdark,
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              }),
        ),
      ],
    );
  }
}
