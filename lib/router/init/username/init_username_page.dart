import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/snack_bar.dart';
import 'package:crea_chess/package/atomic_design/widget/body_template.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/top_progress_indicator.dart';
import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/init/photo/init_photo_page.dart';
import 'package:crea_chess/router/shared/app_bar_actions.dart';
import 'package:crea_chess/router/shared/ccroute.dart';
import 'package:crea_chess/router/shared/form/username_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InitUsernameRoute extends CCRoute {
  InitUsernameRoute._() : super(name: 'username');

  /// Instance
  static final i = InitUsernameRoute._();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InitUsernamePage();
}

class InitUsernamePage extends StatelessWidget {
  const InitUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var initialName = context.read<UserCubit>().state.username;
    if (initialName.isEmpty) {
      initialName =
          context.read<AuthNotVerifiedCubit>().state?.displayName ?? '';
    }
    final usernameFormCubit = UsernameFormCubit(initialName);
    final textController = TextEditingController(text: initialName);

    return Scaffold(
      appBar: AppBar(actions: getSettingsAppBarActions(context)),
      body: BlocProvider(
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
                context.pushRoute(InitPhotoRoute.i);
              case _:
                break;
            }
          },
          builder: (context, form) {
            if (textController.text != form.name.value) {
              textController.text = form.name.value;
            }

            return TopProgressIndicator(
              loading: form.status == UsernameFormStatus.waiting,
              child: BodyTemplate(
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
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Username', // TODO : l10n
                      errorText: form.errorMessage(form.name, context.l10n),
                      errorMaxLines: 3,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => usernameFormCubit.setName(''),
                      ),
                    ),
                    onChanged: usernameFormCubit.setName,
                    onFieldSubmitted: (name) {
                      usernameFormCubit
                        ..setName(name)
                        ..submit();
                    },
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
              ),
            );
          },
        ),
      ),
    );
  }
}
