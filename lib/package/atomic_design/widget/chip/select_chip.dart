import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:flutter/material.dart';

// class SelectChip<T> extends StatefulWidget {
//   SelectChip._({
//     required this.uniqueChoice,
//     required this.values,
//     required this.onSelected,
//     required this.initiallySelectedValues,
//     this.valueBuilder,
//     this.previewBuilder,
//     super.key,
//   }) : assert(values.isNotEmpty, 'SelectChip needs selectable values');

//   factory SelectChip.uniqueChoice({
//     required List<T> values,
//     required void Function(T) onSelected,
//     T? initiallySelectedValue,
//     Widget Function(T)? valueBuilder,
//     Widget Function(T)? previewBuilder,
//   }) {
//     return SelectChip._(
//       uniqueChoice: true,
//       values: values,
//       onSelected: onSelected,
//       initiallySelectedValues: [initiallySelectedValue ?? values.first],
//       valueBuilder: valueBuilder,
//       previewBuilder:
//           previewBuilder == null ? null : (v) => previewBuilder(v.first),
//     );
//   }

//   factory SelectChip.multipleChoices({
//     required List<T> values,
//     required void Function(T) onSelected,
//     List<T>? initiallySelectedValues,
//     Widget Function(T)? valueBuilder,
//     Widget Function(List<T>)? previewBuilder,
//   }) {
//     return SelectChip._(
//       uniqueChoice: false,
//       values: values,
//       onSelected: onSelected,
//       initiallySelectedValues: initiallySelectedValues ?? [],
//       valueBuilder: valueBuilder,
//       previewBuilder: previewBuilder,
//     );
//   }

//   final bool uniqueChoice;
//   final List<T> values;
//   final void Function(T) onSelected;
//   final List<T> initiallySelectedValues;
//   final Widget Function(T)? valueBuilder;
//   final Widget Function(List<T>)? previewBuilder;

//   @override
//   State<SelectChip<T>> createState() => _DropdownSelectorState();
// }

// class _DropdownSelectorState<T> extends State<SelectChip<T>> {
//   late List<T> selectedValues;
//   late final Widget Function(T) valueBuilder;
//   late final Widget Function(List<T>) previewBuilder;

//   @override
//   void initState() {
//     super.initState();
//     valueBuilder = widget.valueBuilder ?? (e) => Text(e.toString());
//     previewBuilder = widget.previewBuilder ??
//         (e) => Row(children: e.map(valueBuilder).toList());
//     setState(() => selectedValues = widget.initiallySelectedValues);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MenuAnchor(
//       builder: (
//         BuildContext context,
//         MenuController controller,
//         Widget? _,
//       ) =>
//           ActionChip(
//         label: previewBuilder(selectedValues),
//         avatar: Icon(
//           Icons.arrow_drop_down,
//           color: Theme.of(context).colorScheme.onSurface,
//         ),
//         onPressed: () {
//           controller.isOpen ? controller.close() : controller.open();
//         },
//       ),
//       menuChildren: widget.values.map(
//         (e) {
//           final selected = selectedValues.contains(e);
//           final top1 = selected && selectedValues.length == 1;
//           return MenuItemButton(
//             style: const ButtonStyle(visualDensity: VisualDensity.compact),
//             closeOnActivate: widget.uniqueChoice && !top1,
//             onPressed: () {
//               // Can't unselect the only selected value
//               if (top1) return;
//               setState(
//                 () => widget.uniqueChoice
//                     ? selectedValues = [e]
//                     : selectedValues.contains(e)
//                         ? selectedValues.length > 1
//                             ? selectedValues.remove(e)
//                             : null
//                         : selectedValues.add(e),
//               );
//               widget.onSelected(e);
//             },
//             child: Card(
//               elevation: 0,
//               color: selected ? null : Colors.transparent,
//               shape: selected
//                   ? RoundedRectangleBorder(
//                       borderRadius: CCBorderRadiusCircular.small,
//                       side: BorderSide(color: CCColor.cardBorder(context)),
//                     )
//                   : null,
//               child: CCPadding.allSmall(child: valueBuilder(e)),
//             ),
//           );
//         },
//       ).toList(),
//     );
//   }
// }

class SelectChip<T> extends StatelessWidget {
  SelectChip._({
    required this.uniqueChoice,
    required this.values,
    required this.onSelected,
    required this.selectedValues,
    this.valueBuilder,
    this.previewBuilder,
    this.showArrow = true,
    super.key,
  }) : assert(values.isNotEmpty, 'SelectChip needs selectable values');

  factory SelectChip.uniqueChoice({
    required List<T> values,
    required void Function(T) onSelected,
    T? selectedValue,
    Widget Function(T)? valueBuilder,
    Widget Function(T)? previewBuilder,
    bool showArrow = true,
  }) {
    return SelectChip._(
      uniqueChoice: true,
      values: values,
      onSelected: onSelected,
      selectedValues: [selectedValue ?? values.first],
      valueBuilder: valueBuilder,
      previewBuilder:
          previewBuilder == null ? null : (v) => previewBuilder(v.first),
      showArrow: showArrow,
    );
  }

  factory SelectChip.multipleChoices({
    required List<T> values,
    required void Function(T) onSelected,
    List<T>? selectedValues,
    Widget Function(T)? valueBuilder,
    Widget Function(List<T>)? previewBuilder,
    bool showArrow = true,
  }) {
    return SelectChip._(
      uniqueChoice: false,
      values: values,
      onSelected: onSelected,
      selectedValues: selectedValues ?? [],
      valueBuilder: valueBuilder,
      previewBuilder: previewBuilder,
      showArrow: showArrow,
    );
  }

  final bool uniqueChoice;
  final List<T> values;
  final void Function(T) onSelected;
  final List<T> selectedValues;
  final Widget Function(T)? valueBuilder;
  final Widget Function(List<T>)? previewBuilder;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final valueBuilderSafe = valueBuilder ?? (e) => Text(e.toString());
    final previewBuilderSafe = previewBuilder ??
        (e) => Row(children: e.map(valueBuilderSafe).toList());
    return MenuAnchor(
      builder: (
        BuildContext context,
        MenuController controller,
        Widget? _,
      ) =>
          ActionChip(
        label: previewBuilderSafe(selectedValues),
        avatar: showArrow
            ? Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).colorScheme.onSurface,
              )
            : null,
        onPressed: () {
          controller.isOpen ? controller.close() : controller.open();
        },
      ),
      menuChildren: values.map(
        (e) {
          final selected = selectedValues.contains(e);
          final top1 = selected && selectedValues.length == 1;
          return MenuItemButton(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            closeOnActivate: uniqueChoice && !top1,
            onPressed: () => onSelected(e),
            child: Card(
              elevation: 0,
              color: selected ? null : Colors.transparent,
              shape: selected
                  ? RoundedRectangleBorder(
                      borderRadius: CCBorderRadiusCircular.small,
                      side: BorderSide(color: CCColor.cardBorder(context)),
                    )
                  : null,
              child: CCPadding.allSmall(child: valueBuilderSafe(e)),
            ),
          );
        },
      ).toList(),
    );
  }
}
