import 'package:crea_chess/package/game/speed.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ChallengeSorterCubit extends HydratedCubit<Speed?> {
  ChallengeSorterCubit() : super(null);

  @override
  Speed? fromJson(Map<String, dynamic> json) {
    final val = json['speed'];
    if (val.runtimeType != String) return null;
    return Speed.fromString(val as String);
  }

  @override
  Map<String, dynamic>? toJson(Speed? state) {
    return {'speed': state.toString()};
  }

  void setSpeed(Speed? speed) => emit(speed);
}
