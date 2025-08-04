import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Elements/e_emoji_name_input.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class AddTaskPopup extends StatefulWidget {
  const AddTaskPopup({super.key, required this.isRepeating});

  final bool isRepeating;

  @override
  State<AddTaskPopup> createState() => _AddTaskPopupState();
}

class _AddTaskPopupState extends State<AddTaskPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadiusBox),
        ),
        child: Column(
          children: [
            EEmojiNameInput(
              onChangeEmoji: (newEmoji) {
                print(newEmoji);
              },
              onChangeName: (newName) {
                print(newName);
              },
              onChangeImportant: (newIsImportant) {
                print(newIsImportant);
              },
            ),
          ],
        ),
      ),
    );
  }
}
