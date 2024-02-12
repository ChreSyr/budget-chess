import 'package:chessground/chessground.dart';
import 'package:crea_chess/route/play/setup/setup_board.dart';
import 'package:crea_chess/route/play/setup/setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupBody extends StatelessWidget {
  const SetupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SetupCubit(
        side: Side.black,
        fen: '8/3qK3/8/8/8/8/3QK3/8',
      ),
      child: const _SetupBody(),
    );
  }
}

class _SetupBody extends StatelessWidget {
  const _SetupBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupCubit, BoardData>(
      builder: (context, boardData) {
        return SetupBoard(
          size: MediaQuery.of(context).size.width,
          data: boardData,
          onMove: context.read<SetupCubit>().onMove,
        );
      },
    );
  }
}
