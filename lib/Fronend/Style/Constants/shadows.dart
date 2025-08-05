import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';

const shadowScaffoldAppbar = BoxShadow(
  color: shadowColor,
  blurRadius: 2,
  offset: Offset(0, 3),
  spreadRadius: 1,
);

const shadowTaskElement = BoxShadow(
  color: shadowColor,
  blurRadius: 5,
  offset: Offset(0, 4),
  spreadRadius: -0.5,
);

const shadowIconDoneButtons = Shadow(
  color: shadowColor,
  blurRadius: 3,
  offset: Offset(0, 3),
);

const buttonAddTask = BoxShadow(
  color: shadowColor,
  blurRadius: 2,
  offset: Offset(1, 4),
  spreadRadius: 2,
);
