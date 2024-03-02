import 'dart:async';

import 'package:crea_chess/package/atomic_design/widget/body_template.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationBody extends RouteBody {
  const EmailVerificationBody({super.key});

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.signin;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, User?>(
      listener: (context, user) {
        if (user == null) return;
        if (user.emailVerified) context.push('/user/modify_name');
      },
      child: const _EmailVerificationBody(),
    );
  }
}

class _EmailVerificationBody extends StatelessWidget {
  const _EmailVerificationBody();

  @override
  Widget build(BuildContext context) {
    return BodyTemplate(
      loading: false,
      emoji: '📬',
      title: context.l10n.verifyMailbox,
      children: [
        Text(
          context.l10n.verifyEmailExplainLink(
            context.read<AuthenticationCubit>().state?.email ?? 'ERROR',
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
