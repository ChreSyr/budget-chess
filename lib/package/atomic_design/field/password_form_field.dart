import 'package:crea_chess/package/atomic_design/field/input_decoration.dart';
import 'package:flutter/material.dart';

class PasswordFromField extends StatefulWidget {
  const PasswordFromField({
    super.key,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.onFieldSubmitted,
  });

  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  State<PasswordFromField> createState() => _PasswordFromFieldState();
}

class _PasswordFromFieldState extends State<PasswordFromField> {
  bool isObscure = true;

  void toggleIsObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: CCInputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        suffixIcon: IconButton(
          onPressed: toggleIsObscure,
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: isObscure,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: const [
        AutofillHints.password,
        AutofillHints.newPassword,
      ],
      // style: TextStyle(color: CCColor.fieldTextColor),
    );
  }
}
