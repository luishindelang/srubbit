import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_time_picker.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

class SelectTimeFromUntil extends StatefulWidget {
  const SelectTimeFromUntil({
    super.key,
    required this.onTimeSelect,
    this.isRepeating,
    this.onIsRepeating,
    this.timeFrom,
    this.timeUntil,
  });

  final void Function(TimeOfDay?, TimeOfDay?) onTimeSelect;
  final bool? isRepeating;
  final void Function(bool)? onIsRepeating;
  final TimeOfDay? timeFrom;
  final TimeOfDay? timeUntil;

  @override
  State<SelectTimeFromUntil> createState() => _SelectTimeFromUntilState();
}

class _SelectTimeFromUntilState extends State<SelectTimeFromUntil> {
  bool isRepeating = false;
  bool showTime = false;
  TimeOfDay? timeFrom;
  TimeOfDay? timeUntil;

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
        timeFrom = newTime ?? timeFrom;
        widget.onTimeSelect(timeFrom, timeUntil);
      }),
    );
  }

  void openTimeUntilPicker() {
    if (timeFrom != null) {
      timeUntil ??= TimeOfDay.now();

      showDialog<TimeOfDay>(
        context: context,
        builder: (context) => ETimePicker(time: timeUntil!),
      ).then(
        (newTime) => setState(() {
          timeUntil = newTime ?? timeUntil;
          widget.onTimeSelect(timeFrom, timeUntil);
        }),
      );
    }
  }

  void onShowTime() {
    setState(() {
      if (showTime) {
        timeFrom = null;
        timeUntil = null;
      }
      showTime = !showTime;
    });
  }

  @override
  void initState() {
    if (widget.isRepeating != null) isRepeating = widget.isRepeating!;
    timeFrom = widget.timeFrom;
    timeUntil = widget.timeUntil;
    if (timeFrom != null) {
      showTime = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: newTaskBodySedePadding,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment:
            widget.onIsRepeating != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.onIsRepeating != null,
            child: CButton(
              onPressed:
                  () => setState(() {
                    isRepeating = !isRepeating;
                    if (widget.onIsRepeating != null) {
                      widget.onIsRepeating!(isRepeating);
                    }
                  }),
              backgroundColor:
                  isRepeating ? buttonColor : buttonBackgroundColor,
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
                    textRepeating,
                    style: isRepeating ? buttonSelected : buttonSelect,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              CButton(
                onPressed: onShowTime,
                backgroundColor: buttonBackgroundColor,
                splashColor: buttonSplashColor,
                radius: borderRadiusButtons,
                paddingVert: 6,
                paddingHor: 14,
                child: Row(
                  children: [
                    Text(showTime ? '-' : '+', style: buttonSelect),
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
                            "$textFrom ${showTimeString(timeFrom)}",
                            style: buttonSelect,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('-', style: buttonSelect),
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
                            "$textUntil ${showTimeString(timeUntil)}",
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
