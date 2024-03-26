import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/live_games_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/router/app/chats/chat_home_page.dart';
import 'package:crea_chess/router/app/friends/search_friend/search_friend_delegate.dart';
import 'package:crea_chess/router/app/hub/game/game_prefs_cubit.dart';
import 'package:crea_chess/router/app/hub/setup/board_settings_cubit.dart';
import 'package:crea_chess/router/app/nav_notifier.dart';
import 'package:crea_chess/router/app/side_routes.dart';
import 'package:crea_chess/router/rooter_provider.dart';
import 'package:crea_chess/router/shared/settings/preferences/preferences_cubit.dart';
import 'package:crea_chess/router/shared/settings/preferences/preferences_state.dart';
import 'package:crea_chess/router/sso/signin/signin_cubit.dart';
import 'package:crea_chess/router/sso/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetChess extends StatefulWidget {
  const BudgetChess({super.key});

  @override
  State<BudgetChess> createState() => _BudgetChessState();
}

class _BudgetChessState extends State<BudgetChess> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onStateChange: (state) {
        final profile = userCRUD.userCubit.state;
        if (profile.id.isEmpty) return;
        if (state == AppLifecycleState.resumed && profile.isConnected != true) {
          userCRUD.update(
            documentId: profile.id,
            data: profile.copyWith(isConnected: true),
          );
        } else if (state != AppLifecycleState.resumed &&
            profile.isConnected == true) {
          userCRUD.update(
            documentId: profile.id,
            data: profile.copyWith(isConnected: false),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthNotVerifiedCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(
          create: (context) => authenticationCRUD.authProviderStatusCubit,
        ),
        BlocProvider(create: (context) => PreferencesCubit()),
        BlocProvider(create: (context) => SigninCubit()),
        BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => SideRoutesCubit()),
        BlocProvider(create: (context) => NavNotifCubit()),
        BlocProvider(create: (context) => RelationsCubit()),
        BlocProvider(create: (context) => NewMessagesCubit()),
        BlocProvider(create: (context) => QueriedUsersCubit()),
        BlocProvider(create: (context) => BoardSettingsCubit()),
        BlocProvider(create: (context) => GamePrefsCubit()),
        BlocProvider(create: (context) => LiveGamesCubit()),
      ],
      child: RouterProvider(
        builder: (router) => NavNotifier(
          child: BlocBuilder<PreferencesCubit, PreferencesState>(
            builder: (context, preferences) {
              final color = preferences.seedColor.color;
              return MaterialApp.router(
                title: 'Budget-Chess Beta',
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.fromSeed(
                    brightness: preferences.brightness,
                    seedColor: color,
                    primary: color,
                  ),
                ),
                // hide debug banner at topleft
                debugShowCheckedModeBanner: false,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates:
                    AppLocalizations.localizationsDelegates,
                locale: locales[preferences.languageCode],
                routerConfig: router,
              );
            },
          ),
        ),
      ),
    );
  }
}
