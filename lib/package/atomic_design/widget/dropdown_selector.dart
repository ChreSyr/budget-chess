import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:flutter/material.dart';

class DropdownSelector<T> extends StatefulWidget {
  DropdownSelector({
    required this.values,
    required this.onSelected,
    this.initialValue,
    this.valueBuilder,
    super.key,
  }) : assert(values.isNotEmpty, 'DropdownSelector needs selectable values');

  final List<T> values;
  final void Function(T) onSelected;
  final T? initialValue;
  final Widget Function(T)? valueBuilder;

  @override
  State<DropdownSelector<T>> createState() => _DropdownSelectorState();
}

class _DropdownSelectorState<T> extends State<DropdownSelector<T>> {
  late T selectedValue;
  late final Widget Function(T) valueBuilder;

  @override
  void initState() {
    super.initState();
    valueBuilder = widget.valueBuilder ?? (e) => Text(e.toString());
    setState(() => selectedValue = widget.initialValue ?? widget.values.first);
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (
        BuildContext context,
        MenuController controller,
        Widget? _,
      ) =>
          ActionChip(
        label: valueBuilder(selectedValue),
        avatar: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () {
          controller.isOpen ? controller.close() : controller.open();
        },
      ),
      menuChildren: widget.values
          .map(
            (e) => MenuItemButton(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {
                setState(() => selectedValue = e);
                widget.onSelected(e);
              },
              child: Card(
                elevation: 0,
                color: selectedValue == e ? null : Colors.transparent,
                shape: selectedValue == e
                    ? RoundedRectangleBorder(
                        borderRadius: CCBorderRadiusCircular.small,
                        side: BorderSide(color: CCColor.cardBorder(context)),
                      )
                    : null,
                child: CCPadding.allSmall(child: valueBuilder(e)),
              ),
            ),
          )
          .toList(),
    );
  }
}
