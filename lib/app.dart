import 'dart:ui';

import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/live_games_cubit.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/preferences/preferences_cubit.dart';
import 'package:crea_chess/package/preferences/preferences_state.dart';
import 'package:crea_chess/route/friends/friends_body.dart';
import 'package:crea_chess/route/friends/search_friend/search_friend_body.dart';
import 'package:crea_chess/route/hub/game/game_prefs_cubit.dart';
import 'package:crea_chess/route/hub/setup/board_settings_cubit.dart';
import 'package:crea_chess/route/nav_notifier.dart';
import 'package:crea_chess/route/router.dart';
import 'package:crea_chess/route/side_routes.dart';
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
        if (profile == null) return;
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
        BlocProvider(
          create: (context) => authenticationCRUD.authProviderStatusCubit,
        ),
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(create: (context) => userCRUD.userCubit),
        BlocProvider(create: (context) => SideRoutesCubit()),
        BlocProvider(create: (context) => NavNotifCubit()),
        BlocProvider(create: (context) => FriendRequestsCubit()),
        BlocProvider(create: (context) => PreferencesCubit()),
        BlocProvider(create: (context) => QueriedUsersCubit()),
        BlocProvider(create: (context) => BoardSettingsCubit()),
        BlocProvider(create: (context) => GamePrefsCubit()),
        BlocProvider(create: (context) => LiveGamesCubit()),
      ],
      child: NavNotifier(
        child: BlocBuilder<PreferencesCubit, PreferencesState>(
          builder: (context, preferences) {
            final color = preferences.seedColor.color;
            return MaterialApp.router(
              title: 'Crea-Chess Bêta',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  brightness: preferences.brightness,
                  seedColor: color,
                  primary: color,
                ),
              ),
              debugShowCheckedModeBanner: false, // hide debug banner at topleft
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: locales[preferences.languageCode],
              // hub: const NavPage(),
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
