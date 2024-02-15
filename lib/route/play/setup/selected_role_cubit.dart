import 'package:chessground/chessground.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SelectedRoleCubit extends Cubit<Role?> {
  SelectedRoleCubit() : super(null);

  void selectRole(Role? role) => emit(role);
}
