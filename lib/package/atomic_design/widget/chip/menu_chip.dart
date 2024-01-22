import 'package:flutter/material.dart';

class MenuChip extends StatelessWidget {
  const MenuChip({
    required this.label,
    required this.menuChildren,
    this.avatar,
    super.key,
  });

  final Widget label;
  final List<Widget> menuChildren;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (
        BuildContext context,
        MenuController controller,
        Widget? _,
      ) =>
          ActionChip(
        label: label,
        avatar: avatar,
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
      ),
      menuChildren: menuChildren,
    );
  }
}
