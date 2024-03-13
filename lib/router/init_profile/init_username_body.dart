import 'package:crea_chess/package/atomic_design/field/input_decoration.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/body_template.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/shared/emergency_app_bar.dart';
import 'package:crea_chess/router/shared/form/username_form.dart';
import 'package:crea_chess/router/shared/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InitUsernameBody extends RouteBody {
  const InitUsernameBody({super.key});

  @override
  List<Widget> getActions(BuildContext context) {
    return getEmergencyAppBarActions(context);
  }

  @override
  String getTitle(AppLocalizations l10n) => '';

  @override
  Widget build(BuildContext context) {
    final initialName = context.read<UserCubit>().state.username;
    final usernameFormCubit = UsernameFormCubit(initialName);
    final textController = TextEditingController(text: initialName);

    return BlocProvider(
      create: (context) => usernameFormCubit,
      child: BlocConsumer<UsernameFormCubit, UsernameForm>(
        listener: (context, form) {
          switch (form.status) {
            case UsernameFormStatus.usernameTaken:
            case UsernameFormStatus.unexpectedError:
              snackBarError(
                context,
                context.l10n.formError(form.status.name),
              );
              usernameFormCubit.clearStatus();
            case UsernameFormStatus.success:
              usernameFormCubit.clearStatus();
              context.push('/photo');
            case _:
              break;
          }
        },
        builder: (context, form) {
          if (textController.text != form.name.value) {
            textController.text = form.name.value;
          }

          return BodyTemplate(
            loading: form.status == UsernameFormStatus.waiting,
            children: [
              // emoji
              const Text(
                '👀',
                style: TextStyle(fontSize: CCWidgetSize.xxsmall),
                textAlign: TextAlign.center,
              ),

              // title
              Text(
                context.l10n.chooseGoodUsername,
                textAlign: TextAlign.center,
              ),
              CCGap.xlarge,

              // mail field
              TextFormField(
                autofocus: true,
                controller: textController,
                decoration: CCInputDecoration(
                  errorText: form.errorMessage(form.name, context.l10n),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => usernameFormCubit.setName(''),
                  ),
                ),
                onChanged: usernameFormCubit.setName,
              ),

              CCGap.xlarge,

              // sign in button
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: usernameFormCubit.submit,
                  child: Text(context.l10n.next),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
