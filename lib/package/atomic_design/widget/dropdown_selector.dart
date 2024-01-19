import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:flutter/material.dart';

class DropdownSelector<T> extends StatefulWidget {
  DropdownSelector._({
    required this.uniqueChoice,
    required this.values,
    required this.onSelected,
    required this.initiallySelectedValues,
    this.valueBuilder,
    this.previewBuilder,
    super.key,
  }) : assert(values.isNotEmpty, 'DropdownSelector needs selectable values');

  factory DropdownSelector.uniqueChoice({
    required List<T> values,
    required void Function(T) onSelected,
    T? initiallySelectedValue,
    Widget Function(T)? valueBuilder,
  }) {
    return DropdownSelector._(
      uniqueChoice: true,
      values: values,
      onSelected: onSelected,
      initiallySelectedValues: [initiallySelectedValue ?? values.first],
      valueBuilder: valueBuilder,
    );
  }

  factory DropdownSelector.multipleChoices({
    required List<T> values,
    required void Function(T) onSelected,
    List<T>? initiallySelectedValues,
    Widget Function(T)? valueBuilder,
    Widget Function(List<T>)? previewBuilder,
  }) {
    return DropdownSelector._(
      uniqueChoice: false,
      values: values,
      onSelected: onSelected,
      initiallySelectedValues: initiallySelectedValues ?? [],
      valueBuilder: valueBuilder,
      previewBuilder: previewBuilder,
    );
  }

  final bool uniqueChoice;
  final List<T> values;
  final void Function(T) onSelected;
  final List<T> initiallySelectedValues;
  final Widget Function(T)? valueBuilder;
  final Widget Function(List<T>)? previewBuilder;

  @override
  State<DropdownSelector<T>> createState() => _DropdownSelectorState();
}

class _DropdownSelectorState<T> extends State<DropdownSelector<T>> {
  late List<T> selectedValues;
  late final Widget Function(T) valueBuilder;
  late final Widget Function(List<T>) previewBuilder;

  @override
  void initState() {
    super.initState();
    valueBuilder = widget.valueBuilder ?? (e) => Text(e.toString());
    previewBuilder = widget.previewBuilder ??
        (e) => Row(children: e.map(valueBuilder).toList());
    setState(() => selectedValues = widget.initiallySelectedValues);
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
        label: previewBuilder(selectedValues),
        avatar: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () {
          controller.isOpen ? controller.close() : controller.open();
        },
      ),
      menuChildren: widget.values.map(
        (e) {
          final selected = selectedValues.contains(e);
          return MenuItemButton(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            closeOnActivate: widget.uniqueChoice,
            onPressed: () {
              setState(
                () => widget.uniqueChoice
                    ? selectedValues = [e]
                    : selectedValues.contains(e)
                        ? selectedValues.length > 1
                            ? selectedValues.remove(e)
                            : null
                        : selectedValues.add(e),
              );
              widget.onSelected(e);
            },
            child: Card(
              elevation: 0,
              color: selected ? null : Colors.transparent,
              shape: selected
                  ? RoundedRectangleBorder(
                      borderRadius: CCBorderRadiusCircular.small,
                      side: BorderSide(color: CCColor.cardBorder(context)),
                    )
                  : null,
              child: CCPadding.allSmall(child: valueBuilder(e)),
            ),
          );
        },
      ).toList(),
    );
  }
}
