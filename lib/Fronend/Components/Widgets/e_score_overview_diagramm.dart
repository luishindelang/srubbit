import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_score_bar_account.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class EScoreOverviewDiagramm extends StatelessWidget {
  const EScoreOverviewDiagramm({super.key, required this.accounts});

  final List<DsAccount> accounts;

  @override
  Widget build(BuildContext context) {
    const double height = 250;

    int getMax() {
      int highest = 10;
      for (var account in accounts) {
        if (account.score > highest) highest = account.score;
      }
      return highest;
    }

    int getMin() {
      int lowest = getMax() - 10;
      for (var account in accounts) {
        if (account.score < lowest) lowest = account.score;
      }
      return lowest;
    }

    int max = getMax();
    int min = getMin();

    List<Widget> buildSteps() {
      const steps = 4;
      final diff = min - max;
      final stepSize = diff / steps;

      return List.generate(steps + 1, (i) {
        final value = (max + i * stepSize).round();
        return Text(value.toString(), style: scaleOverview);
      });
    }

    double getAccountHeight(DsAccount account) {
      final double maxHeight = height - 40;
      final int score = account.score;
      final double percentage = (score - min) / (max - min);
      return (maxHeight * percentage) + 10;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: height - 20,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buildSteps(),
          ),
        ),
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: buttonColor, width: 3),
                bottom: BorderSide(color: buttonColor, width: 3),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:
                    accounts
                        .map(
                          (account) => EScoreBarAccount(
                            account: account,
                            height: getAccountHeight(account),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
