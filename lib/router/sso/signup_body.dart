import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/field/input_decoration.dart';
import 'package:crea_chess/package/atomic_design/field/password_form_field.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/body_template.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/form/signup/signup_cubit.dart';
import 'package:crea_chess/package/form/signup/signup_form.dart';
import 'package:crea_chess/package/form/signup/signup_status.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/shared/emergency_app_bar.dart';
import 'package:crea_chess/router/shared/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBody extends RouteBody {
  const SignupBody({super.key});

  @override
  String getTitle(AppLocalizations l10n) => l10n.signup;

  @override
  List<Widget> getActions(BuildContext context) =>
      getEmergencyAppBarActions(context);

  @override
  Widget build(BuildContext context) {
    final signupCubit = context.read<SignupCubit>();

    return BlocConsumer<SignupCubit, SignupForm>(
      listener: (context, form) {
        switch (form.status) {
          case SignupStatus.unexpectedError:
          case SignupStatus.mailTaken: // Todo : l10n
            snackBarError(
              context,
              context.l10n.formError(form.status.name),
            );
            signupCubit.clearFailure();
          case _:
            break;
        }
      },
      builder: (context, form) {
        return BodyTemplate(
          loading: form.status == SignupStatus.waiting,
          children: [
            // emoji
            const Text(
              '🎉',
              style: TextStyle(fontSize: CCWidgetSize.xxsmall),
              textAlign: TextAlign.center,
            ),

            // title
            Text(
              context.l10n.welcomeAmongUs,
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
              onChanged: signupCubit.emailChanged,
              textInputAction: TextInputAction.next,
            ),

            CCGap.small,

            // password textfield
            PasswordFromField(
              hintText: context.l10n.password,
              errorText: form.errorMessage(form.password, context.l10n),
              initialValue: form.password.value,
              onChanged: signupCubit.passwordChanged,
              onFieldSubmitted: (value) => signupCubit.submit(),
            ),

            CCGap.medium,

            // conditions
            CheckboxListTile(
              value: form.acceptConditions.value,
              onChanged: signupCubit.acceptedConditionsChanged,
              title: Text(
                context.l10n.iAcceptConditions,
                style: form.errorMessage(
                          form.acceptConditions,
                          context.l10n,
                        ) ==
                        null
                    ? null
                    : TextStyle(color: CCColor.error(context)),
              ),
            ),

            CCGap.medium,

            // sign in button
            FilledButton(
              onPressed: signupCubit.submit,
              child: Text(context.l10n.signCreateAccount),
            ),
          ],
        );
      },
    );
  }
}
