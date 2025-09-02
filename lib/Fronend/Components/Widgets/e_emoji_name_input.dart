import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_text_input.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class EEmojiNameInput extends StatefulWidget {
  const EEmojiNameInput({
    super.key,
    required this.isImportant,
    required this.onChangeName,
    required this.onChangeEmoji,
    required this.onChangeImportant,
    this.name,
    this.emojy,
  });

  final bool isImportant;
  final void Function(String) onChangeName;
  final void Function(String) onChangeEmoji;
  final void Function(bool) onChangeImportant;
  final String? name;
  final String? emojy;

  @override
  State<EEmojiNameInput> createState() => _EEmojiNameInputState();
}

class _EEmojiNameInputState extends State<EEmojiNameInput> {
  String emoji = '';
  final _nameController = TextEditingController();
  final _emojiController = TextEditingController();
  final _emojiFocus = FocusNode();
  late bool isImportant;

  @override
  void initState() {
    isImportant = widget.isImportant;
    if (widget.name != null) _nameController.text = widget.name!;
    if (widget.emojy != null) emoji = widget.emojy!;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emojiController.dispose();
    _emojiFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isImportant ? importantTaskColor : scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadiusBox),
          topRight: Radius.circular(borderRadiusBox),
          bottomLeft: Radius.circular(borderRadiusTaskElement),
          bottomRight: Radius.circular(borderRadiusTaskElement),
        ),
        boxShadow: [shadowTaskElement],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                CButton(
                  onPressed: () {
                    _emojiFocus.requestFocus();
                  },
                  splashColor: buttonSplashColor,
                  radius: borderRadiusBox,
                  child:
                      emoji.isEmpty
                          ? Icon(
                            Icons.add_reaction_outlined,
                            color: buttonColor,
                            size: newTaskEmojiSizeButton,
                          )
                          : Text(emoji, style: newTaskEmoji),
                ),
                Offstage(
                  offstage: true,
                  child: SizedBox(
                    height: 0,
                    width: 0,
                    child: CTextInput(
                      controller: _emojiController,
                      focusNode: _emojiFocus,
                      hintText: "",
                      inputFormatter: [],
                      onChanged:
                          (String newEmoji) => setState(() {
                            emoji = _emojiController.text;
                            _emojiController.text = "";
                            _emojiFocus.unfocus();
                            widget.onChangeEmoji(newEmoji);
                          }),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CTextInput(
                    controller: _nameController,
                    fontSize: inputText.fontSize!,
                    fontWeight: inputText.fontWeight!,
                    hintText: "name eingeben",
                    textColor: inputText.color!,
                    onChanged: (newName) => widget.onChangeName(newName),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 50),
          CButton(
            onPressed:
                () => setState(() {
                  isImportant = !isImportant;
                  widget.onChangeImportant(isImportant);
                }),
            radius: borderRadiusBox,
            child:
                isImportant
                    ? FAssets.importantActive
                    : FAssets.importantInactive,
          ),
        ],
      ),
    );
  }
}
