import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Elements/e_select_account_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/test_data.dart';

class ESelectAccount extends StatefulWidget {
  const ESelectAccount({
    super.key,
    required this.accounts,
    required this.selectedAccounts,
    required this.onSelectedAccount,
    this.selectAll = false,
  });

  final List<DsAccount> accounts;
  final List<DsAccount> selectedAccounts;
  final void Function(List<DsAccount>) onSelectedAccount;
  final bool selectAll;

  @override
  State<ESelectAccount> createState() => _ESelectAccountState();
}

class _ESelectAccountState extends State<ESelectAccount> {
  List<DsAccount> selectedAccounts = [];
  late bool selectAll;

  void onAccountSelect(DsAccount account) {
    setState(() {
      if (selectedAccounts.contains(account)) {
        selectedAccounts.remove(account);
      } else {
        selectedAccounts.add(account);
      }
      selectAll = false;
      widget.onSelectedAccount(selectedAccounts);
    });
  }

  void onAllSelect() {
    setState(() {
      if (!selectAll) {
        selectedAccounts = [];
      }
      selectAll = !selectAll;
      widget.onSelectedAccount(selectedAccounts);
    });
  }

  void newAccount(DsAccount newAccount) {
    setState(() {
      widget.accounts.add(newAccount);
    });
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
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(Icons.person, size: sizeIconDonePopup, color: buttonColor),
                ESelectAccountButton(
                  onPressed: onAllSelect,
                  text: "Alle",
                  isSelected: selectAll,
                  selectedBackground: buttonColor,
                ),
                Row(
                  children:
                      widget.accounts.map((account) {
                        return ESelectAccountButton(
                          onPressed: () => onAccountSelect(account),
                          text: account.name,
                          isSelected: selectedAccounts.contains(account),
                          selectedBackground: account.color,
                        );
                      }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(paddingButton),
                  child: CButton(
                    onPressed: () => newAccount(createAccount()),
                    backgroundColor: buttonBackgroundColor,
                    radius: borderRadiusButtons,
                    paddingVert: 6,
                    child: Icon(Icons.add_rounded, color: textColor, size: 25),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
