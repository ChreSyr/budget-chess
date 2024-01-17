import 'package:crea_chess/package/atomic_design/button/filled_circle_button.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/l10n/get_locale_flag.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/package/preferences/preferences_cubit.dart';
import 'package:crea_chess/package/preferences/preferences_state.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsBody extends MainRouteBody {
  const SettingsBody({super.key}) : super(id: 'settings', icon: Icons.settings);

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.settings;
  }

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.read<PreferencesCubit>();

    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, preferences) {
        const buttonSize = CCWidgetSize.small;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledCircleButton.icon(
              icon: preferences.isDarkMode ? Icons.nightlight : Icons.sunny,
              onPressed: preferencesCubit.toggleTheme,
              size: buttonSize,
            ),
            CCGap.large,
            FilledCircleButton.icon(
              icon: null,
              onPressed: () => Modal.show(
                context: context,
                title: context.l10n.chooseColor,
                sections: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: CCSize.large,
                    mainAxisSpacing: CCSize.large,
                    children: SeedColor.values
                        .map(
                          (seedColor) => FilledButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              backgroundColor: seedColor.color,
                            ),
                            onPressed: () => context
                              ..pop()
                              ..read<PreferencesCubit>()
                                  .setSeedColor(seedColor),
                            child: const Text(''),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              size: buttonSize,
            ),
            CCGap.large,
            FilledCircleButton.text(
              text: getLocaleFlag(context.l10n.localeName),
              onPressed: preferencesCubit.toggleLocale,
              size: buttonSize,
            ),
          ],
        );
      },
    );
  }
}
