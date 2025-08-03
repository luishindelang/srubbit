import 'package:flutter/widgets.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class FAssets {
  static final String _path = "assets/";
  static final String _completeActive = "Complete_active.png";
  static final String _completeInactive = "Complete_inactive.png";
  static final String _doneActive = "Done_active.png";
  static final String _doneInactive = "Done_inactive.png";
  static final String _importantActive = "Important_active.png";
  static final String _importantInactive = "Important_inactive.png";
  static final String _xActive = "X_active.png";
  static final String _xInactive = "X_inactive.png";

  static Image completeActive = Image.asset(
    _path + _completeActive,
    fit: BoxFit.fill,
  );
  static Image completeInactive = Image.asset(
    _path + _completeInactive,
    fit: BoxFit.fill,
  );
  static Image doneActive = Image.asset(_path + _doneActive);
  static Image doneInactive = Image.asset(_path + _doneInactive);
  static Image importantActive = Image.asset(
    _path + _importantActive,
    height: imageImportantSize,
  );
  static Image importantInactive = Image.asset(
    _path + _importantInactive,
    height: imageImportantSize,
  );
  static Image xActive = Image.asset(_path + _xActive);
  static Image xInactive = Image.asset(_path + _xInactive);
}
