import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ENewTaskRepeating extends StatefulWidget {
  const ENewTaskRepeating({super.key});

  @override
  State<ENewTaskRepeating> createState() => _ENewTaskRepeatingState();
}

class _ENewTaskRepeatingState extends State<ENewTaskRepeating> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: newTaskBodySedePadding,
        vertical: 5.0,
      ),
    );
  }
}
