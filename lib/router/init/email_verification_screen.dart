import 'dart:async';

import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/body_template.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyTemplate(
      children: [
        // emoji
        const Text(
          '📬',
          style: TextStyle(fontSize: CCWidgetSize.xxsmall),
          textAlign: TextAlign.center,
        ),

        // title
        Text(
          context.l10n.verifyMailbox,
          textAlign: TextAlign.center,
        ),
        CCGap.xlarge,

        Text(
          context.l10n.verifyEmailExplainLink(
            context.read<AuthNotVerifiedCubit>().state?.email ?? 'ERROR',
          ),
          textAlign: TextAlign.center,
        ),
        CCGap.xxlarge,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ResendButton(),
            CCGap.large,
            FilledButton(
              onPressed: authenticationCRUD.reloadUser,
              child: Text(context.l10n.continue_),
            ),
          ],
        ),
      ],
    );
  }
}

class ResendButton extends StatefulWidget {
  const ResendButton({super.key});

  @override
  State<ResendButton> createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  int delay = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    authenticationCRUD.sendEmailVerification();
    delay = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _decrease();
      if (delay == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _decrease() {
    setState(() {
      delay--;
    });
  }

  void _reset() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _decrease();
      if (delay == 0) {
        timer.cancel();
      }
    });
    setState(() {
      delay = 15;
    });
  }

  @override
  Widget build(BuildContext context) {
    return delay == 0
        ? ElevatedButton(
            onPressed: () {
              authenticationCRUD.sendEmailVerification();
              _reset();
            },
            child: Text(context.l10n.verifyEmailResendLink),
          )
        : ElevatedButton(
            onPressed: null,
            child: Text('${context.l10n.verifyEmailResendLink} ($delay)'),
          );
  }
}
