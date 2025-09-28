import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

class ESelectAccountColor extends StatelessWidget {
  const ESelectAccountColor({super.key, required this.account});

  final DsAccount account;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusTaskElement),
      ),
      backgroundColor: scaffoldBackgroundColor,
      child: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadiusTaskElement - 1),
                ),
                boxShadow: [shadowScaffoldAppbar],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(textUserColor, style: scaffoldAppBarTitleMissed),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children:
                    userColors
                        .map(
                          (color) => InkWell(
                            onTap: () {
                              account.update(newColor: color);
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color:
                                      color == account.color
                                          ? buttonColor
                                          : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
