import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/text_style.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:flutter/material.dart';

class ModalSelectRowData<T> {
  ModalSelectRowData({
    required this.title,
    required this.choices,
    this.titleIcon,
    this.choiceBuilder,
  });

  final String title;
  final Widget? titleIcon;
  final List<T> choices;
  final Widget Function(T)? choiceBuilder;
}

class ModalSelect {
  static void show<T>({
    required BuildContext context,
    required String title,
    required List<ModalSelectRowData<T>> choices,
    required T selected,
    required void Function(T) onSelected,
  }) {
    Modal.show(
      context: context,
      title: title,
      sections: choices
              .map<Widget>(
                (e) => _ModalSelectRow<T>(
                  title: e.title,
                  titleIcon: e.titleIcon,
                  choices: e.choices,
                  selected: selected,
                  onSelected: onSelected,
                  choiceBuilder: e.choiceBuilder ??
                      (choice) =>
                          Text(choice.toString(), style: TextStyleExt.bold),
                ),
              )
              .toList() +
          [CCGap.xlarge],
    );
  }
}

class _ModalSelectRow<T> extends StatelessWidget {
  const _ModalSelectRow({
    required this.title,
    required this.choices,
    required this.selected,
    required this.onSelected,
    required this.choiceBuilder,
    this.titleIcon,
  });

  final String title;
  final Widget? titleIcon;
  final Iterable<T> choices;
  final T selected;
  final void Function(T) onSelected;
  final Widget Function(T) choiceBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: titleIcon,
          title: Text(title),
        ),
        Wrap(
          spacing: CCSize.medium,
          runSpacing: CCSize.medium,
          children: choices
              .map(
                (choice) => ChoiceChip(
                  showCheckmark: false,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  label: choiceBuilder(choice),
                  selected: selected == choice,
                  onSelected: (bool selected) {
                    if (selected) {
                      onSelected(choice);
                      Navigator.pop(context);
                    }
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
