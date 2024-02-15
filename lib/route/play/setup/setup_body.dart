import 'package:chessground/chessground.dart';
import 'package:crea_chess/package/atomic_design/chess/setup_board.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/firebase/firestore/game/inventory/inventory_model.dart';
import 'package:crea_chess/package/firebase/firestore/game/setup/setup_model.dart';
import 'package:crea_chess/route/play/setup/inventory.dart';
import 'package:crea_chess/route/play/setup/setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupBody extends StatelessWidget {
  const SetupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SetupCubit(
        side: Side.white,
        halfFen: '8/8/8/8',
      ),
      child: const _SetupBody(),
    );
  }
}

class _SetupBody extends StatelessWidget {
  const _SetupBody();

  @override
  Widget build(BuildContext context) {
    final setupCubit = context.read<SetupCubit>();
    final side = setupCubit.side;
    const settings = BoardSettings(
      colorScheme: BoardColorScheme.blue3,
    );

    return BlocBuilder<SetupCubit, SetupModel>(
      builder: (context, setup) {
        return Column(
          children: [
            SetupBoard(
              size: CCSize.boardSizeOf(context),
              halfFen: setup.halfFenAs(side),
              color: side,
              onDrop: setupCubit.onDrop,
              onMove: setupCubit.onMove,
              onRemove: setupCubit.onRemove,
              settings: settings,
            ),
            Inventory(
              inventory: const InventoryModel(
                id: 'id',
                ownerId: 'ownerId',
              ),
              color: side,
              settings: settings,
            ),
          ],
        );
      },
    );
  }
}
