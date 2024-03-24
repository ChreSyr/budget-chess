import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/router/app/chats/chat/model/input_clear_mode.dart';
import 'package:crea_chess/router/app/chats/chat/model/send_button_visibility_mode.dart';
import 'package:crea_chess/router/app/chats/chat/widget/input/input_text_field_controller.dart';
import 'package:crea_chess/router/app/chats/chat/widget/input/send_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A class that represents bottom bar widget with a text field, attachment and
/// send buttons inside. By default hides send button when text field is empty.
class Input extends StatefulWidget {
  /// Creates [Input] widget.
  const Input({
    required this.onSendPressed,
    super.key,
    this.options = const InputOptions(),
  });

  /// Will be called on [SendButton] tap. Has [types.PartialText] which can
  /// be transformed to [types.TextMessage] and added to the messages list.
  final void Function(String) onSendPressed;

  /// Customisation options for the [Input].
  final InputOptions options;

  @override
  State<Input> createState() => _InputState();
}

/// [Input] widget state.
class _InputState extends State<Input> {
  late final _inputFocusNode = FocusNode(
    onKeyEvent: (node, event) {
      if (event.physicalKey == PhysicalKeyboardKey.enter &&
          !HardwareKeyboard.instance.physicalKeysPressed.any(
            (el) => <PhysicalKeyboardKey>{
              PhysicalKeyboardKey.shiftLeft,
              PhysicalKeyboardKey.shiftRight,
            }.contains(el),
          )) {
        if (kIsWeb && _textController.value.isComposingRangeValid) {
          return KeyEventResult.ignored;
        }
        if (event is KeyDownEvent) {
          _handleSendPressed();
        }
        return KeyEventResult.handled;
      } else {
        return KeyEventResult.ignored;
      }
    },
  );

  bool _sendButtonVisible = false;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = InputTextFieldController();
    _handleSendButtonVisibilityModeChange();
  }

  void _handleSendButtonVisibilityModeChange() {
    _textController.removeListener(_handleTextControllerChange);
    if (widget.options.sendButtonVisibilityMode ==
        SendButtonVisibilityMode.hidden) {
      _sendButtonVisible = false;
    } else if (widget.options.sendButtonVisibilityMode ==
        SendButtonVisibilityMode.editing) {
      _sendButtonVisible = _textController.text.trim() != '';
      _textController.addListener(_handleTextControllerChange);
    } else {
      _sendButtonVisible = true;
    }
  }

  void _handleSendPressed() {
    final trimmedText = _textController.text.trim();
    if (trimmedText.isNotEmpty) {
      widget.onSendPressed(trimmedText);

      if (widget.options.inputClearMode == InputClearMode.always) {
        _textController.clear();
      }
    }
  }

  void _handleTextControllerChange() {
    if (_textController.value.isComposingRangeValid) {
      return;
    }
    setState(() {
      _sendButtonVisible = _textController.text.trim() != '';
    });
  }

  @override
  void didUpdateWidget(covariant Input oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.options.sendButtonVisibilityMode !=
        oldWidget.options.sendButtonVisibilityMode) {
      _handleSendButtonVisibilityModeChange();
    }
  }

  @override
  void dispose() {
    _inputFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _inputFocusNode.requestFocus(),
      child: Focus(
        autofocus: !widget.options.autofocus,
        child: Row(
          children: [
            Expanded(
              child: CCPadding.allSmall(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: CCBorderRadiusCircular.large,
                    color: context.colorScheme.primaryContainer,
                  ),
                  child: TextField(
                    enabled: widget.options.enabled,
                    autocorrect: widget.options.autocorrect,
                    autofocus: widget.options.autofocus,
                    enableSuggestions: widget.options.enableSuggestions,
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Message', // TODO : l10n
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: CCSize.medium,
                      ),
                    ),
                    focusNode: _inputFocusNode,
                    keyboardType: widget.options.keyboardType,
                    maxLines: 5,
                    minLines: 1,
                    onChanged: widget.options.onTextChanged,
                    onTap: widget.options.onTextFieldTap,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              ),
            ),
            SendButton(
              onPressed: _sendButtonVisible ? _handleSendPressed : null,
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class InputOptions {
  const InputOptions({
    this.inputClearMode = InputClearMode.always,
    this.keyboardType = TextInputType.multiline,
    this.sendButtonVisibilityMode = SendButtonVisibilityMode.editing,
    this.onTextChanged,
    this.onTextFieldTap,
    this.autocorrect = true,
    this.autofocus = false,
    this.enableSuggestions = true,
    this.enabled = true,
  });

  /// Controls the [Input] clear behavior. Defaults to [InputClearMode.always].
  final InputClearMode inputClearMode;

  /// Controls the [Input] keyboard type. Defaults to [TextInputType.multiline].
  final TextInputType keyboardType;

  /// Will be called whenever the text inside [TextField] changes.
  final void Function(String)? onTextChanged;

  /// Will be called on [TextField] tap.
  final VoidCallback? onTextFieldTap;

  /// Controls the visibility behavior of the [SendButton] based on the
  /// [TextField] state inside the [Input] widget.
  /// Defaults to [SendButtonVisibilityMode.editing].
  final SendButtonVisibilityMode sendButtonVisibilityMode;

  /// Controls the [TextInput] autocorrect behavior. Defaults to [true].
  final bool autocorrect;

  /// Whether [TextInput] should have focus. Defaults to [false].
  final bool autofocus;

  /// Controls the [TextInput] enableSuggestions behavior. Defaults to [true].
  final bool enableSuggestions;

  /// Controls the [TextInput] enabled behavior. Defaults to [true].
  final bool enabled;
}
