import 'package:crea_chess/route/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavNotifCubit extends Cubit<Map<String, Set<String>>> {
  NavNotifCubit()
      : super({for (var e in mainRouteBodies.map((e) => e.id)) e: {}});

  void add(String key, String value) {
    final newState = Map<String, Set<String>>.from(state);
    if (!newState.containsKey(key)) {
      newState[key] = {value};
    } else {
      newState[key]!.add(value);
    }
    emit(newState);
  }

  void remove(String key, String value) {
    if (!state.containsKey(key)) return;
    final newState = Map<String, Set<String>>.from(state);
    newState[key]!.remove(value);
    emit(newState);
  }
}
