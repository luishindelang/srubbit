import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_select_account_button.dart';
import 'package:scrubbit/Fronend/Pages/Popup/edit_account_popup.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Language/eng.dart';

class ESelectAccount extends StatefulWidget {
  const ESelectAccount({
    super.key,
    required this.accounts,
    required this.selectedAccounts,
    required this.onSelectedAccount,
    required this.onSelectAll,
    required this.selectAll,
    this.reverse = false,
    this.withShadow = false,
    this.neverUnselect = true,
  });

  final List<DsAccount> accounts;
  final List<DsAccount> selectedAccounts;
  final void Function(List<DsAccount>) onSelectedAccount;
  final void Function() onSelectAll;
  final bool selectAll;
  final bool reverse;
  final bool withShadow;
  final bool neverUnselect;

  @override
  State<ESelectAccount> createState() => _ESelectAccountState();
}

class _ESelectAccountState extends State<ESelectAccount> {
  List<DsAccount> selectedAccounts = [];
  late bool selectAll;

  void onAccountSelect(DsAccount account) {
    setState(() {
      if (selectedAccounts.any((a) => a.id == account.id)) {
        selectedAccounts.removeWhere((a) => a.id == account.id);
      } else {
        selectedAccounts.add(account);
      }
      selectAll = false;
      if (widget.neverUnselect && selectedAccounts.isEmpty) {
        selectAll = true;
      }
      widget.onSelectedAccount(selectedAccounts);
    });
  }

  void onAllSelect() {
    setState(() {
      if (!selectAll) {
        selectedAccounts = [];
      }
      if (widget.neverUnselect) {
        selectAll = true;
      } else {
        selectAll = !selectAll;
      }
      widget.onSelectedAccount(selectedAccounts);
    });
  }

  void onEditAccouts() {
    showDialog(
      context: context,
      builder: (context) => EditAccountPopup(accounts: widget.accounts),
    );
  }

  @override
  void initState() {
    selectAll = widget.selectAll;
    selectedAccounts = widget.selectedAccounts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.reverse ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Icon(Icons.person, size: sizeIconDonePopup, color: buttonColor),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: widget.reverse,
            child: Row(
              children: [
                ESelectAccountButton(
                  onPressed: () {
                    onAllSelect();
                    widget.onSelectAll();
                  },
                  text: textAll,
                  isSelected: selectAll,
                  selectedBackground: buttonColor,
                  withShadow: widget.withShadow,
                ),
                ...widget.accounts.map((account) {
                  return ESelectAccountButton(
                    onPressed: () => onAccountSelect(account),
                    text: account.name,
                    isSelected: selectedAccounts.any((a) => a.id == account.id),
                    selectedBackground: account.color,
                    withShadow: widget.withShadow,
                  );
                }),
                Visibility(
                  visible: !widget.withShadow,
                  child: Padding(
                    padding: const EdgeInsets.all(paddingButton),
                    child: Container(
                      decoration:
                          widget.withShadow
                              ? BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  borderRadiusButtons,
                                ),
                                boxShadow: [shadowTaskElement],
                              )
                              : null,
                      child: CButton(
                        onPressed: onEditAccouts,
                        backgroundColor: buttonBackgroundColor,
                        radius: borderRadiusButtons,
                        paddingVert: 6,
                        child: Icon(
                          Icons.add_rounded,
                          color: textColor,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: widget.withShadow,
          child: Padding(
            padding: const EdgeInsets.all(paddingButton),
            child: Container(
              decoration:
                  widget.withShadow
                      ? BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          borderRadiusButtons,
                        ),
                        boxShadow: [shadowTaskElement],
                      )
                      : null,
              child: CButton(
                onPressed: onEditAccouts,
                backgroundColor: buttonBackgroundColor,
                radius: borderRadiusButtons,
                paddingVert: 6,
                child: Icon(
                  Icons.settings_rounded,
                  color: buttonColor,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
