// Abstract CRUD class
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SubCollectionCRUD<T> {
  const SubCollectionCRUD({
    required this.parentCollectionName,
    required this.collectionName,
  });

  final String parentCollectionName;
  final String collectionName;

  T? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  );
  Map<String, Object?> modelToJson(T? bool, SetOptions? _);

  CollectionReference<T?> _collection(String parentDocumentId) =>
      FirebaseFirestore.instance
          .collection('$parentCollectionName/$parentDocumentId/$collectionName')
          .withConverter<T?>(
            toFirestore: modelToJson,
            fromFirestore: jsonToModel,
          );

  Query<T?> get _collectionGroup => FirebaseFirestore.instance
      .collectionGroup(collectionName)
      .withConverter<T?>(
        toFirestore: modelToJson,
        fromFirestore: jsonToModel,
      );

  Future<void> create({
    required String parentDocumentId,
    required T data,
    String? documentId,
  }) async {
    await _collection(parentDocumentId).doc(documentId).set(data);
  }

  Future<T?> read({
    required String parentDocumentId,
    required String documentId,
  }) async {
    return _collection(parentDocumentId).doc(documentId).get().then(
          (doc) => doc.data(),
        );
  }

  Future<Iterable<T>> readFiltered({
    required String parentDocumentId,
    required Query<T?> Function(CollectionReference<T?>) filter,
  }) {
    return filter(_collection(parentDocumentId)).get().then(
          (query) => query.docs.map((doc) => doc.data()).whereType<T>(),
        );
  }

  Stream<T?> stream({
    required String parentDocumentId,
    required String documentId,
  }) {
    return _collection(parentDocumentId)
        .doc(documentId)
        .snapshots()
        .map((doc) => doc.data());
  }

  Stream<Iterable<T>> streamAll({required String parentDocumentId}) {
    return _collection(parentDocumentId).snapshots().map(
          (query) => query.docs.map((doc) => doc.data()).whereType<T>(),
        );
  }

  Stream<Iterable<T>> streamFiltered({
    required String parentDocumentId,
    required Query<T?> Function(CollectionReference<T?> collection) filter,
  }) {
    return filter(_collection(parentDocumentId)).snapshots().map(
          (query) => query.docs.map((doc) => doc.data()).whereType<T>(),
        );
  }

  /// Queries accross all the collections named like this SubCollectionCRUD
  Stream<Iterable<T>> streamGroupFiltered({
    required Query<T?> Function(Query<T?> query) filter,
  }) {
    return filter(_collectionGroup).snapshots().map(
          (query) => query.docs.map((doc) => doc.data()).whereType<T>(),
        );
  }

  Future<void> update({
    required String parentDocumentId,
    required String documentId,
    required T data,
  }) async {
    await _collection(parentDocumentId)
        .doc(documentId)
        .update(modelToJson(data, null));
  }

  Future<void> delete({
    required String parentDocumentId,
    required String documentId,
  }) async {
    await _collection(parentDocumentId).doc(documentId).delete();
  }

  Future<void> deleteAll({required String parentDocumentId}) async {
    for (final documentSnapshot
        in (await _collection(parentDocumentId).get()).docs) {
      await documentSnapshot.reference.delete();
    }
  }
}
