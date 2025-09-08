import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class EScoreBarAccount extends StatelessWidget {
  const EScoreBarAccount({
    super.key,
    required this.account,
    required this.height,
  });

  final DsAccount account;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(account.name, style: scoreBarName),
          Container(
            width: 60,
            height: height,
            decoration: BoxDecoration(
              color: account.color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
