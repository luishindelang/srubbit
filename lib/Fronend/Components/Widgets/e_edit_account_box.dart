import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_icon_button.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_text_input.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_select_account_color.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class EEditAccountBox extends StatefulWidget {
  const EEditAccountBox({
    super.key,
    required this.account,
    required this.delete,
    required this.isEdit,
    required this.onChange,
  });

  final DsAccount account;
  final VoidCallback delete;
  final bool isEdit;
  final void Function() onChange;

  @override
  State<EEditAccountBox> createState() => _EEditAccountBoxState();
}

class _EEditAccountBoxState extends State<EEditAccountBox> {
  final _nameController = TextEditingController();
  final _nameFocus = FocusNode();

  void onChange() {
    if (widget.isEdit) {
      widget.onChange();
    }
  }

  void onChangeColor() {
    showDialog(
      context: context,
      builder: (context) => ESelectAccountColor(account: widget.account),
    ).then(
      (_) => setState(() {
        onChange();
        _nameFocus.unfocus();
      }),
    );
  }

  @override
  void initState() {
    if (widget.account.name != "name") {
      _nameController.text = widget.account.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: buttonBackgroundColor,
                  borderRadius: BorderRadius.circular(borderRadiusButtons),
                  boxShadow: [shadowTaskElement],
                ),
                child: InkWell(
                  onTap: () => _nameFocus.requestFocus(),
                  borderRadius: BorderRadius.circular(borderRadiusButtons),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Text(widget.account.name, style: editAccount),
                  ),
                ),
              ),
              Offstage(
                offstage: true,
                child: SizedBox(
                  height: 0,
                  width: 0,
                  child: CTextInput(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    hintText: "",
                    onChanged:
                        (String newName) => setState(() {
                          widget.account.update(newName: newName);
                          onChange();
                        }),
                  ),
                ),
              ),
              SizedBox(width: 15),
              InkWell(
                onTap: onChangeColor,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: widget.account.color,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color:
                          widget.account.color == Colors.white
                              ? boxBorderColor
                              : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          CIconButton(
            onPressed: widget.delete,
            icon: Icon(
              Icons.delete_outline_rounded,
              size: 35,
              color: buttonColor,
            ),
          ),
        ],
      ),
    );
  }
}
