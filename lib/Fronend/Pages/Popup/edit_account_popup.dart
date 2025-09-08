import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_edit_account_box.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class EditAccountPopup extends StatefulWidget {
  const EditAccountPopup({super.key, this.accounts});

  final List<DsAccount>? accounts;

  @override
  State<EditAccountPopup> createState() => _EditAccountPopupState();
}

class _EditAccountPopupState extends State<EditAccountPopup> {
  List<DsAccount> accounts = [];
  List<DsAccount> accountsUpdate = [];
  List<DsAccount> accountsAdd = [];
  List<DsAccount> accountsRemove = [];

  void add() {
    setState(() {
      final newaccount = DsAccount(name: "name", color: Colors.white);
      accounts.add(newaccount);
      accountsAdd.add(newaccount);
    });
  }

  void delete(DsAccount account) {
    setState(() {
      accounts.remove(account);
      bool isNew = accountsAdd.remove(account);
      if (!isNew) {
        accountsRemove.add(account);
      }
    });
  }

  @override
  void initState() {
    if (widget.accounts != null) {
      for (var oldAcccount in widget.accounts!) {
        accounts.add(oldAcccount.copyWith());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final account = context.read<UiAccount>();
    final home = context.read<UiHome>();
    return Dialog(
      insetPadding: EdgeInsets.all(40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusTaskElement),
      ),
      backgroundColor: scaffoldBackgroundColor,
      child: SizedBox(
        width: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadiusTaskElement - 1),
                ),
                boxShadow: [shadowScaffoldAppbar],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("User Settings", style: scaffoldAppBarTitleMissed),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: buttonBackgroundColor,
                        borderRadius: BorderRadius.circular(
                          borderRadiusButtons,
                        ),
                        boxShadow: [shadowTaskElement],
                      ),
                      child: InkWell(
                        onTap: () => add(),
                        borderRadius: BorderRadius.circular(
                          borderRadiusButtons,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: Text("+ Add user", style: editAccount),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      accounts
                          .map(
                            (account) => EEditAccountBox(
                              account: account,
                              delete: () => delete(account),
                              isEdit: !accountsAdd.contains(account),
                              onChange: () {
                                if (!accountsUpdate.contains(account)) {
                                  accountsUpdate.add(account);
                                }
                              },
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      account.finishEditAccounts(
                        accountsAdd,
                        accountsUpdate,
                        accountsRemove,
                        home,
                      );
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: sizeDoneButtonNewTask,
                      height: sizeDoneButtonNewTask,
                      decoration: BoxDecoration(
                        color: scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [shadowTaskElement],
                      ),
                      child: FAssets.doneActive,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
