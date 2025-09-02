import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrubbit/Backend/Functions/f_input_formatter.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_text_input.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class ENewTaskRepeatingCount extends StatefulWidget {
  const ENewTaskRepeatingCount({
    super.key,
    required this.onIntervallChanged,
    required this.repeatingIntervall,
  });

  final void Function(int) onIntervallChanged;
  final int repeatingIntervall;

  @override
  State<ENewTaskRepeatingCount> createState() => _ENewTaskRepeatingCountState();
}

class _ENewTaskRepeatingCountState extends State<ENewTaskRepeatingCount> {
  late int repeatingIntervall;
  final _emojiController = TextEditingController();
  final _emojiFocus = FocusNode();

  @override
  void initState() {
    repeatingIntervall = widget.repeatingIntervall;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
              child: Text(repeatingIntervall.toString(), style: buttonSelect),
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
                    widget.onIntervallChanged(repeatingIntervall);
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
