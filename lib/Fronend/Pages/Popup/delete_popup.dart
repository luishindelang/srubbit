import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/eng.dart';

class DeletePopup extends StatelessWidget {
  const DeletePopup({super.key, required this.onDelete});

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusTaskElement),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadiusTaskElement),
                topRight: Radius.circular(borderRadiusTaskElement),
              ),
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
            child: Text(textDeleteEntryQuestion, style: deleteTitle),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 40,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  width: sizeDoneButtonMiddle,
                  height: sizeDoneButtonMiddle,
                  child: FAssets.xInactive,
                ),
              ),
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  width: sizeDoneButtonMiddle,
                  height: sizeDoneButtonMiddle,
                  child: FAssets.doneActive,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
