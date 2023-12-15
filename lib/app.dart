import 'package:crea_chess/package/firebase/authentication/authentication_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/preferences/preferences_cubit.dart';
import 'package:crea_chess/package/preferences/preferences_state.dart';
import 'package:crea_chess/route/nav_notif_cubit.dart';
import 'package:crea_chess/route/router.dart';
import 'package:crea_chess/route/user/search_friend/search_friend_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreaChessApp extends StatelessWidget {
  const CreaChessApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authenticationCRUD.authProviderStatusCubit,
        ),
        BlocProvider(
          create: (context) => authenticationCRUD.authenticationCubit,
        ),
        BlocProvider(
          create: (context) => userCRUD.userCubit,
        ),
        BlocProvider(
          create: (context) => NavNotifCubit(),
        ),
        BlocProvider(
          create: (context) => PreferencesCubit(),
        ),
        BlocProvider(
          create: (context) => QueriedUsersCubit(),
        ),
      ],
      child: BlocBuilder<PreferencesCubit, PreferencesState>(
        builder: (context, preferences) {
          final color = preferences.seedColor.color;
          return MaterialApp.router(
            title: 'Crea-Chess Bêta',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: preferences.brightness == Brightness.dark
                  ? ColorScheme.dark(
                      primary: color,
                      secondary: color,
                    )
                  : ColorScheme.light(
                      primary: color,
                      secondary: color,
                    ),
            ),
            debugShowCheckedModeBanner: false, // hide debug banner at topleft
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: locales[preferences.languageCode],
            // home: const NavPage(),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
