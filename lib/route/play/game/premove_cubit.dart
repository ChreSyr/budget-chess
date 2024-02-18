import 'package:crea_chess/package/chessground/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PremoveCubit extends Cubit<CGMove?> {
  PremoveCubit() : super(null);

  void setPremove(CGMove? premove) => emit(premove);
}
