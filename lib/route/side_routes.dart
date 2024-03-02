import 'package:crea_chess/package/atomic_design/border.dart';
import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideRoutesCubit extends Cubit<bool> {
  SideRoutesCubit() : super(false);

  void toggle() => emit(!state);
}

class SideRoutes extends StatelessWidget {
  const SideRoutes({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final showSideRoutes = context.watch<SideRoutesCubit>().state;

    return Stack(
      children: [
        SizedBox.expand(
          child: ColoredBox(
            color: CCColor.primary(context),
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
            onTap:
                showSideRoutes ? context.read<SideRoutesCubit>().toggle : null,
            child: AbsorbPointer(
              absorbing: showSideRoutes,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
