import 'package:crea_chess/package/firebase/firestore/game/inventory/inventory_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryCubit extends Cubit<InventoryModel> {
  InventoryCubit()
      : super(
          const InventoryModel(
            id: 'id',
            ownerId: 'ownerId',
          ),
        );
}
