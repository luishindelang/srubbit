import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrubbit/Backend/Functions/f_input_formatter.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_drop_down.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_text_input.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

class ENewTaskRepeatingIntervall extends StatefulWidget {
  const ENewTaskRepeatingIntervall({super.key});

  @override
  State<ENewTaskRepeatingIntervall> createState() =>
      _ENewTaskRepeatingIntervallState();
}

class _ENewTaskRepeatingIntervallState
    extends State<ENewTaskRepeatingIntervall> {
  int repeatingIntervall = 1;
  final _emojiController = TextEditingController();
  final _emojiFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Wiederholt sich alle:", style: repeatingCategoryTitle),
        Row(
          children: [
            CButton(
              onPressed: () {
                _emojiFocus.requestFocus();
              },
              backgroundColor: buttonBackgroundColor,
              splashColor: buttonSplashColor,
              radius: borderRadiusButtons,
              paddingHor: 12,
              paddingVert: 6,
              child: SizedBox(
                width: 35,
                child: Center(
                  child: Text(
                    repeatingIntervall.toString(),
                    style: buttonSelect,
                  ),
                ),
              ),
            ),
            Offstage(
              offstage: true,
              child: SizedBox(
                height: 0,
                width: 0,
                child: CTextInput(
                  controller: _emojiController,
                  focusNode: _emojiFocus,
                  textInputType: TextInputType.number,
                  hintText: "",
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                    NoLeadingZeroFormatter(),
                  ],
                  onChanged:
                      (String newRepeatingIntervall) => setState(() {
                        if (newRepeatingIntervall.isNotEmpty) {
                          repeatingIntervall = int.parse(newRepeatingIntervall);
                        } else {
                          repeatingIntervall = 1;
                        }
                      }),
                ),
              ),
            ),
            SizedBox(width: 20),
            CDropDown(
              changedItem: (value) {
                return value;
              },
              options: repeatingTypes,
              selectedItemName: repeatingTypes.first,
              dropdownRadius: borderRadiusBox,
              background: buttonBackgroundColor,
              boxBorderWidth: 0,
              boxBorderColor: Colors.transparent,
              textStyle: buttonSelect,
              dropdownIconSize: 20,
              paddingHor: 14,
              paddingVert: 6,
              dropdownOffset: 42,
            ),
          ],
        ),
      ],
    );
  }
}
