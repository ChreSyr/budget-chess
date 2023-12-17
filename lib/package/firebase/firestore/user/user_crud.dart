import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crea_chess/package/firebase/firestore/crud/base_crud.dart';
import 'package:crea_chess/package/firebase/firestore/crud/model_converter.dart';
import 'package:crea_chess/package/firebase/firestore/relationship/relationship_crud.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_cubit.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_model.dart';

class _UserModelConverter implements ModelConverter<UserModel> {
  @override
  UserModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  ) {
    return UserModel.fromFirestore(snapshot);
  }

  @override
  Map<String, dynamic> toFirestore(UserModel data, SetOptions? _) {
    return data.toFirestore();
  }

  @override
  UserModel emptyModel() {
    return UserModel();
  }
}

class _UserCRUD extends BaseCRUD<UserModel> {
  _UserCRUD() : super('user', _UserModelConverter());

  final userCubit = UserCubit();

  @override
  Future<void> create({required String? documentId, required UserModel data}) {
    return super.create(
      documentId: documentId,
      data: data.copyWith(
        createdAt: DateTime.now(),
        usernameLowercase: data.username?.toLowerCase(),
      ),
    );
  }

  /// Delete the user & its relationships
  @override
  Future<void> delete({required String? documentId}) async {
    await super.delete(documentId: documentId);

    final relationships = await relationshipCRUD.readFiltered(
      filter: (collection) =>
          collection.where('users', arrayContains: documentId),
    );
    for (final relationship in relationships) {
      await relationshipCRUD.delete(documentId: relationship.id);
    }
  }

  Stream<Iterable<UserModel>> streamUsername(String username) {
    return streamFiltered(
      filter: (collection) => collection.where(
        'usernameLowercase',
        isEqualTo: username.toLowerCase(),
      ),
    );
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
