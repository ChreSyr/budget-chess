import 'package:crea_chess/package/atomic_design/field/input_decoration.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/body_template.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:crea_chess/route/user/modify_username/modify_username_cubit.dart';
import 'package:crea_chess/route/user/modify_username/modify_username_form.dart';
import 'package:crea_chess/route/user/modify_username/modify_username_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ModifyUsernameBody extends RouteBody {
  const ModifyUsernameBody({super.key});

  @override
  String getTitle(AppLocalizations l10n) {
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state;
    final initialName = user?.username == user?.id ? '' : user?.username ?? '';
    final modifyUsernameCubit = ModifyUsernameCubit(initialName);
    final textController = TextEditingController(text: initialName);

    return BlocProvider(
      create: (context) => modifyUsernameCubit,
      child: BlocConsumer<ModifyUsernameCubit, ModifyUsernameForm>(
        listener: (context, form) {
          switch (form.status) {
            case ModifyUsernameStatus.usernameTaken:
            case ModifyUsernameStatus.unexpectedError:
              snackBarError(
                context,
                context.l10n.formError(form.status.name),
              );
              modifyUsernameCubit.clearFailure();
            case ModifyUsernameStatus.success:
              while (context.canPop()) {
                context.pop();
              }
            case _:
              break;
          }
        },
        builder: (context, form) {
          textController.text = form.name.value;

          return BodyTemplate(
            loading: form.status == ModifyUsernameStatus.waiting,
            emoji: '👀',
            title: context.l10n.chooseGoodUsername,
            children: [
              // mail field
              TextFormField(
                autofocus: true,
                controller: textController,
                decoration: CCInputDecoration(
                  errorText: form.errorMessage(form.name, context.l10n),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => modifyUsernameCubit.setName(''),
                  ),
                ),
                onChanged: modifyUsernameCubit.setName,
              ),

              CCGap.xlarge,

              // sign in button
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: modifyUsernameCubit.submit,
                  child: Text(context.l10n.save),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
