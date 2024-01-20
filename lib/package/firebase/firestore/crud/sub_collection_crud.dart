// Abstract CRUD class
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SubCollectionCRUD<T> {
  const SubCollectionCRUD({
    required this.parentCollectionName,
    required this.collectionName,
    required this.toFirestore,
    required this.fromFirestore,
  });

  final String parentCollectionName;
  final String collectionName;
  final Map<String, Object?> Function(T, SetOptions?) toFirestore;
  final T Function(
    DocumentSnapshot<Map<String, dynamic>>,
    SnapshotOptions?,
  ) fromFirestore;

  CollectionReference<T> _collection(String parentDocumentId) =>
      FirebaseFirestore.instance
          .collection('$parentCollectionName/$parentDocumentId/$collectionName')
          .withConverter<T>(
            toFirestore: toFirestore,
            fromFirestore: fromFirestore,
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
          (snapshot) => snapshot.data(),
        );
  }

  Future<Iterable<T>> readFiltered({
    required String parentDocumentId,
    required Query<T> Function(CollectionReference<T>) filter,
  }) {
    return filter(_collection(parentDocumentId)).get().then(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<T?> stream({
    required String parentDocumentId,
    required String documentId,
  }) {
    final streamController = StreamController<T?>();

    if (documentId.isNotEmpty) {
      _collection(parentDocumentId)
          .doc(documentId)
          .snapshots()
          .listen((snapshot) {
        streamController.add(snapshot.data());
      });
    }

    return streamController.stream;
  }

  Stream<Iterable<T>> streamAll({required String parentDocumentId}) {
    return _collection(parentDocumentId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()),
        );
  }

  Stream<Iterable<T>> streamFiltered({
    required String parentDocumentId,
    required Query<T> Function(CollectionReference<T>) filter,
  }) {
    return filter(_collection(parentDocumentId)).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Future<void> update({
    required String parentDocumentId,
    required String documentId,
    required T data,
  }) async {
    await _collection(parentDocumentId)
        .doc(documentId)
        .update(toFirestore(data, null));
  }

  Future<void> delete({
    required String parentDocumentId,
    required String? documentId,
  }) async {
    await _collection(parentDocumentId).doc(documentId).delete();
  }
}
