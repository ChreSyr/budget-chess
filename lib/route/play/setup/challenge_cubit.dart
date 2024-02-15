import 'package:crea_chess/package/firebase/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeCubit extends Cubit<ChallengeModel> {
  ChallengeCubit()
      : super(
          const ChallengeModel(
            id: '0',
            authorId: 'mael',
            budget: 19,
          ),
        );
}
