import 'package:crea_chess/package/firebase/firestore/game/live_game/account_preferences.dart';
import 'package:crea_chess/package/firebase/firestore/game/live_game/game_indb.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePrefsCubit extends Cubit<GamePrefs> {
  GamePrefsCubit()
      : super(
          const GamePrefs(
            showRatings: true,
            enablePremove: true,
            autoQueen: AutoQueen.never,
            zenMode: Zen.gameAuto,
          ),
        );
}
