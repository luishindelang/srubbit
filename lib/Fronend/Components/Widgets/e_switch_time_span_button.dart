import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_time_span_button.dart';

class ESwitchTimeSpanButton extends StatefulWidget {
  const ESwitchTimeSpanButton({
    super.key,
    required this.isTimeSpan,
    required this.onChange,
  });

  final bool isTimeSpan;
  final void Function(bool) onChange;

  @override
  State<ESwitchTimeSpanButton> createState() => _ESwitchTimeSpanButtonState();
}

class _ESwitchTimeSpanButtonState extends State<ESwitchTimeSpanButton> {
  bool isTimeSpan = false;

  @override
  void initState() {
    isTimeSpan = widget.isTimeSpan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ETimeSpanButton(
      isTimeSpan: isTimeSpan,
      onPressed:
          () => setState(() {
            isTimeSpan = !isTimeSpan;
            widget.onChange(isTimeSpan);
          }),
    );
  }
}
