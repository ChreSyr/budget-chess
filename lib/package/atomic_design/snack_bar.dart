import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:flutter/material.dart';

void _snackBar({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
  required Color textColor,
  Duration duration = const Duration(seconds: 3),
  Widget? action,
  bool canClose = true,
}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        content: DefaultTextStyle(
          style: TextStyle(color: textColor),
          child: GestureDetector(
            child: Row(
              children: [
                Expanded(child: Text(message)),
                if (action != null) action,
                if (canClose)
                  IconButton(
                    color: textColor,
                    onPressed: scaffoldMessenger.removeCurrentSnackBar,
                    icon: const Icon(Icons.close),
                  ),
              ],
            ),
          ),
        ),
        duration: duration,
      ),
    );
}

void snackBarError(BuildContext context, String message) {
  _snackBar(
    context: context,
    message: message,
    textColor: Colors.white,
    backgroundColor: Colors.red,
  );
}

void snackBarNotify(BuildContext context, String message) {
  _snackBar(
    context: context,
    message: message,
    textColor: CCColor.onInverseSurface(context),
    backgroundColor: CCColor.inverseSurface(context),
  );
}

void snackBarClear(BuildContext context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
}
