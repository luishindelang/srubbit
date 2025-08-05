import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Elements/e_time_picker.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class ESelectTimeFromUntil extends StatefulWidget {
  const ESelectTimeFromUntil({super.key, required this.onIsRepeating});

  final void Function(bool) onIsRepeating;

  @override
  State<ESelectTimeFromUntil> createState() => _ESelectTimeFromUntilState();
}

class _ESelectTimeFromUntilState extends State<ESelectTimeFromUntil> {
  bool isRepeating = false;
  bool showTime = false;
  TimeOfDay? timeFrom;
  TimeOfDay? tiemUntil;

  String showTimeString(TimeOfDay? time) {
    if (time != null) {
      return formatTime(time);
    }
    return "--:--";
  }

  void openTimeFromPicker() {
    timeFrom ??= TimeOfDay.now();

    showDialog<TimeOfDay>(
      context: context,
      builder: (context) => ETimePicker(time: timeFrom!),
    ).then(
      (newTime) => setState(() {
        timeFrom = newTime;
      }),
    );
  }

  void openTimeUntilPicker() {
    tiemUntil ??= TimeOfDay.now();

    showDialog<TimeOfDay>(
      context: context,
      builder: (context) => ETimePicker(time: tiemUntil!),
    ).then(
      (newTime) => setState(() {
        tiemUntil = newTime;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CButton(
            onPressed:
                () => setState(() {
                  isRepeating = !isRepeating;
                  widget.onIsRepeating(isRepeating);
                }),
            backgroundColor: isRepeating ? buttonColor : buttonBackgroundColor,
            radius: borderRadiusButtons,
            paddingHor: 14,
            paddingVert: 6,
            child: Row(
              children: [
                Icon(
                  Icons.autorenew_rounded,
                  color: isRepeating ? textNegativeColor : buttonColor,
                  size: 20,
                ),
                SizedBox(width: 5),
                Text(
                  "Repeating",
                  style: isRepeating ? buttonSelected : buttonSelect,
                ),
              ],
            ),
          ),
          Row(
            children: [
              CButton(
                onPressed:
                    () => setState(() {
                      showTime = !showTime;
                    }),
                backgroundColor: buttonBackgroundColor,
                radius: borderRadiusButtons,
                paddingVert: 6,
                paddingHor: 14,
                child: Row(
                  children: [
                    Text(showTime ? "-" : "+", style: buttonSelect),
                    SizedBox(width: 5),
                    Icon(
                      Icons.access_time_rounded,
                      color: buttonColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: showTime,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    CButton(
                      onPressed: openTimeFromPicker,
                      backgroundColor: buttonBackgroundColor,
                      radius: borderRadiusButtons,
                      paddingVert: 6,
                      paddingHor: 14,
                      child: Row(
                        children: [
                          Text(
                            "von ${showTimeString(timeFrom)}",
                            style: buttonSelect,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("-", style: buttonSelect),
                    SizedBox(width: 10),
                    CButton(
                      onPressed: openTimeUntilPicker,
                      backgroundColor: buttonBackgroundColor,
                      radius: borderRadiusButtons,
                      paddingVert: 6,
                      paddingHor: 14,
                      child: Row(
                        children: [
                          Text(
                            "bis ${showTimeString(tiemUntil)}",
                            style: buttonSelect,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
