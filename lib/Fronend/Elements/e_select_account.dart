import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Elements/e_select_account_button.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/test_data.dart';

class ESelectAccount extends StatelessWidget {
  const ESelectAccount({
    super.key,
    required this.accounts,
    required this.selectedAccounts,
    required this.selectAll,
    required this.onSelectAll,
    required this.onAccountToggle,
    required this.onAddAccount,
  });

  final List<DsAccount> accounts;
  final List<String> selectedAccounts;
  final bool selectAll;

  final VoidCallback onSelectAll;
  final void Function(DsAccount account) onAccountToggle;
  final void Function(DsAccount newAccount) onAddAccount;

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
                  onPressed: onSelectAll,
                  text: "Alle",
                  isSelected: selectAll,
                  selectedBackground: buttonColor,
                ),
                Row(
                  children:
                      accounts.map((account) {
                        return ESelectAccountButton(
                          onPressed: () => onAccountToggle(account),
                          text: account.name,
                          isSelected: selectedAccounts.contains(account.id),
                          selectedBackground: account.color,
                        );
                      }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(paddingButton),
                  child: CButton(
                    onPressed: () => onAddAccount(createAccount()),
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
