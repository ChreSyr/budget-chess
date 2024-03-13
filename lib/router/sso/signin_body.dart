import 'package:crea_chess/package/atomic_design/dialog/user/reset_password.dart';
import 'package:crea_chess/package/atomic_design/field/input_decoration.dart';
import 'package:crea_chess/package/atomic_design/field/password_form_field.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/body_template.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/form/signin/signin_cubit.dart';
import 'package:crea_chess/package/form/signin/signin_form.dart';
import 'package:crea_chess/package/form/signin/signin_status.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/shared/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninBody extends RouteBody {
  const SigninBody({super.key});

  @override
  String getTitle(AppLocalizations l10n) => l10n.signin;

  @override
  // TODO : preferences & help
  List<Widget> getActions(BuildContext context) => [];

  @override
  Widget build(BuildContext context) {
    final signinCubit = context.read<SigninCubit>();

    return BlocConsumer<SigninCubit, SigninForm>(
      listener: (context, form) {
        switch (form.status) {
          case SigninStatus.invalidCredentials:
          case SigninStatus.tooManyRequests:
          case SigninStatus.unexpectedError:
            snackBarError(
              context,
              context.l10n.formError(form.status.name),
            );
            signinCubit.clearFailure();
          case SigninStatus.resetPasswordSuccess:
            snackBarNotify(
              context,
              context.l10n.verifyMailbox,
            );
            signinCubit.clearFailure();
          case _:
            break;
        }
      },
      builder: (context, form) {
        return BodyTemplate(
          loading: form.status == SigninStatus.waiting,
          children: [
              // emoji
              const Text(
                '😄',
                style: TextStyle(fontSize: CCWidgetSize.xxsmall),
                textAlign: TextAlign.center,
              ),

        // title
        Text(
        context.l10n.welcomeBack,
          textAlign: TextAlign.center,
        ),
        CCGap.xlarge,

            // mail field
            TextFormField(
              autofocus: true,
              decoration: CCInputDecoration(
                hintText: context.l10n.email,
                errorText: form.errorMessage(form.email, context.l10n),
              ),
              initialValue: form.email.value,
              keyboardType: TextInputType.emailAddress,
              onChanged: signinCubit.emailChanged,
              textInputAction: TextInputAction.next,
            ),

            CCGap.small,

            // password textfield
            PasswordFromField(
              hintText: context.l10n.password,
              errorText: form.errorMessage(form.password, context.l10n),
              initialValue: form.password.value,
              onChanged: signinCubit.passwordChanged,
              onFieldSubmitted: (value) => signinCubit.submit(),
            ),

            CCGap.small,

            // forgot password?
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => showResetPasswordDialog(
                  context,
                  form.email.value,
                ),
                child: Text(context.l10n.passwordForgot),
              ),
            ),

            CCGap.medium,

            // sign in button
            FilledButton(
              onPressed: signinCubit.submit,
              child: Text(context.l10n.signin),
            ),
          ],
        );
      },
    );
  }
}
