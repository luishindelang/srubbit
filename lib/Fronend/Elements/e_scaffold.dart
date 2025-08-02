import 'package:flutter/material.dart';
import 'package:scrubbit/Style/Constants/colors.dart';
import 'package:scrubbit/Style/Constants/sizes.dart';
import 'package:scrubbit/Style/Constants/text_style.dart';

class EScaffold extends StatelessWidget {
  const EScaffold({
    super.key,
    required this.weekday,
    required this.date,
    required this.body,
  });

  final String weekday;
  final String date;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text(weekday, style: scaffoldAppBarTitleBold),
            Text(", $date", style: scaffoldAppBarTitleNormal),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                scaffoldTopBarGradient1,
                scaffoldTopBarGradient1,
                scaffoldTopBarGradient2,
                scaffoldTopBarGradient3,
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(paddingScaffold),
        child: body,
      ),
    );
  }
}
