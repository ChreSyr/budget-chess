import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/badge.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/atomic_design/widget/user/user_photo.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/nav_notifier.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:crea_chess/route/user/user_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SideRoutesCubit extends Cubit<bool> {
  SideRoutesCubit() : super(false);

  void toggle() => emit(!state);

  void reset() => emit(false);
}

class SideRoutes extends StatelessWidget {
  const SideRoutes({
    required this.sideRouteDatas,
    required this.child,
    super.key,
  });

  final Widget child;

  final Iterable<MainRouteData> sideRouteDatas;

  @override
  Widget build(BuildContext context) {
    final showSideRoutes = context.watch<SideRoutesCubit>().state;
    final backgroundColor = CCColor.background(context);
    final currentTheme = Theme.of(context);
    final newTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: switch (currentTheme.brightness) {
          Brightness.dark => Brightness.light,
          Brightness.light => Brightness.dark,
        },
        seedColor: currentTheme.primaryColor,
        primary: currentTheme.primaryColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStateColor.resolveWith(
            (states) => backgroundColor,
          ),
          foregroundColor: MaterialStateColor.resolveWith(
            (states) => backgroundColor,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(color: backgroundColor),
    );

    return Material(
      child: Stack(
        children: [
          SizedBox.expand(
            child: ColoredBox(
              color: CCColor.primary(context),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: CCWidgetSize.large2,
              child: CCPadding.allLarge(
                child: Theme(
                  data: newTheme,
                  child: BlocBuilder<NavNotifCubit, NavNotifs>(
                    builder: (context, navNotifs) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CCGap.xxxlarge,
                          CountBadge(
                            count: navNotifs.count(
                              routeId: UserBody.data.id,
                            ),
                            child: const ProfileButton(),
                            offset: const Offset(-10, -10),
                          ),
                          CCGap.small,
                          const Divider(),
                          ...sideRouteDatas.map(SideRouteButton.new),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: showSideRoutes
                ? const Duration(milliseconds: 300)
                : const Duration(milliseconds: 150),
            transform: showSideRoutes
                ? (Matrix4.rotationZ(-0.1).scaled(0.8)
                  ..translate(
                    -MediaQuery.of(context).size.width * 0.8,
                    100,
                  ))
                : Matrix4.rotationZ(0),
            curve: showSideRoutes ? Curves.easeOutBack : Curves.linear,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: CCBorderRadiusCircular.medium,
            ),
            clipBehavior: Clip.antiAlias,
            child: GestureDetector(
              onTap: showSideRoutes
                  ? context.read<SideRoutesCubit>().toggle
                  : null,
              child: AbsorbPointer(
                absorbing: showSideRoutes,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        context.push('/user');
        context.read<SideRoutesCubit>().reset();
      },
      icon: UserPhoto(
        photo: context.watch<UserCubit>().state?.photo,
      ),
      label: const Text('Voir mon profil'), // TODO : l10n
    );
  }
}

class SideRouteButton extends StatelessWidget {
  const SideRouteButton(this.routeData, {super.key});

  final MainRouteData routeData;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        context.push('/${routeData.id}');
        context.read<SideRoutesCubit>().reset();
      },
      icon: Icon(routeData.icon),
      label: Text(routeData.getTitle(context.l10n)),
    );
  }
}
