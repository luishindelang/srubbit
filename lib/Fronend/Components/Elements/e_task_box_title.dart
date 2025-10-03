import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class ETaskBoxTitle extends StatelessWidget {
  const ETaskBoxTitle({
    super.key,
    required this.title,
    required this.children,
    this.behindTitle,
    this.flex = 1,
    this.withScroll = true,
    this.withScrollPhysiks = true,
  });

  final String title;
  final List<Widget> children;
  final Widget? behindTitle;
  final int flex;
  final bool withScroll;
  final bool withScrollPhysiks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.all(paddingBox),
        decoration: BoxDecoration(
          color: taskListBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadiusBox)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: taskBoxTitle),
                if (behindTitle != null) behindTitle!,
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child:
                  withScroll
                      ? SingleChildScrollView(
                        physics:
                            withScrollPhysiks
                                ? AlwaysScrollableScrollPhysics()
                                : NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children,
                        ),
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
