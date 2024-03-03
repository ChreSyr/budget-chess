import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/crud/collection_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';

class _UserCRUD extends CollectionCRUD<UserModel> {
  _UserCRUD() : super(collectionName: 'user');

  final userCubit = UserCubit();

  @override
  UserModel? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    try {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return UserModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, Object?> modelToJson(UserModel? data, SetOptions? _) {
    return (data?.toJson()
          ?..removeWhere(
            (key, value) => key == 'id' || value == null,
          )) ??
        {};
  }

  Future<void> onSignIn({required String authUid}) async {
    final user = await read(documentId: authUid);
    print('onSignIn user: $user');
    if (user == null) return;
    await update(documentId: authUid, data: user.copyWith(isConnected: true));
  }

  Future<void> onSignOut({required String? authUid}) async {
    if (authUid == null) return;
    final user = await read(documentId: authUid);
    if (user == null) return;
    await update(documentId: authUid, data: user.copyWith(isConnected: false));
  }

  @override
  Future<void> create({required UserModel data, String? documentId}) {
    return super.create(
      documentId: documentId,
      data: data.copyWith(
        createdAt: DateTime.now(),
        usernameLowercase: data.username.toLowerCase(),
      ),
    );
  }

  Stream<UserModel?> streamUsername(String username) {
    return streamFiltered(
      filter: (collection) => collection.where(
        'usernameLowercase',
        isEqualTo: username.toLowerCase(),
      ),
    ).asyncMap((list) => list.firstOrNull);
  }

  Future<bool> usernameIsTaken(String username) async {
    final users = await readFiltered(
      filter: (collection) => collection.where(
        'usernameLowercase',
        isEqualTo: username.toLowerCase(),
      ),
    );
    return users.isNotEmpty;
  }
}

final userCRUD = _UserCRUD();
