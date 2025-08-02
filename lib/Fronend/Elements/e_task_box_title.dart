import 'package:flutter/material.dart';
import 'package:scrubbit/Style/Constants/colors.dart';
import 'package:scrubbit/Style/Constants/sizes.dart';
import 'package:scrubbit/Style/Constants/text_style.dart';

class ETaskBoxTitle extends StatelessWidget {
  const ETaskBoxTitle({super.key, this.title, required this.children});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(paddingBox),
        decoration: BoxDecoration(
          color: taskListBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadiusBox)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title!, style: taskBoxTitle),
            SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(child: Column(children: children)),
            ),
          ],
        ),
      ),
    );
  }
}
