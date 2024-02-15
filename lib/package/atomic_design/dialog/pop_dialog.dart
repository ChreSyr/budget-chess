import 'package:flutter/material.dart';

// for some reason, dialogContext.pop pops the pageContext
void popDialog(BuildContext dialogContext) => Navigator.pop(dialogContext);
