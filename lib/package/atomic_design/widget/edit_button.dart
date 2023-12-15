import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({this.onPressed, this.priorityHigh = false, super.key});

  final void Function()? onPressed;
  final bool priorityHigh;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: priorityHigh
          ? const Icon(Icons.priority_high, color: Colors.red)
          : const Icon(Icons.edit, color: Colors.white),
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => CCColor.transparentGrey,
        ),
      ),
    );
  }
}
