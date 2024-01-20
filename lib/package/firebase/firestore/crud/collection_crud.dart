// Abstract CRUD class
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CollectionCRUD<T> {
  CollectionCRUD({
    required this.collectionName,
    required this.toFirestore,
    required T Function(
      DocumentSnapshot<Map<String, dynamic>>,
      SnapshotOptions?,
    ) fromFirestore,
  }) : _collection = FirebaseFirestore.instance
            .collection(collectionName)
            .withConverter<T>(
              toFirestore: toFirestore,
              fromFirestore: fromFirestore,
            );

  final String collectionName;
  final CollectionReference<T> _collection;
  final Map<String, Object?> Function(T, SetOptions?) toFirestore;

  Future<void> create({required T data, String? documentId}) async {
    await _collection.doc(documentId).set(data);
  }

  Future<T?> read({required String documentId}) async {
    return _collection.doc(documentId).get().then(
          (snapshot) => snapshot.data(),
        );
  }

  Future<Iterable<T>> readFiltered({
    required Query<T> Function(CollectionReference<T>) filter,
  }) {
    return filter(_collection).get().then(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<T?> stream({required String documentId}) {
    final streamController = StreamController<T?>();

    if (documentId.isNotEmpty) {
      // streamController.add(_converter.emptyModel());
      // } else {
      _collection.doc(documentId).snapshots().listen((snapshot) {
        streamController.add(snapshot.data());
      });
    }

    return streamController.stream;
  }

  Stream<Iterable<T>> streamAll() {
    return _collection.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<Iterable<T>> streamFiltered({
    required Query<T> Function(CollectionReference<T>) filter,
  }) {
    return filter(_collection).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Future<void> update({required String documentId, required T data}) async {
    await _collection.doc(documentId).update(toFirestore(data, null));
  }

  Future<void> delete({required String? documentId}) async {
    await _collection.doc(documentId).delete();
  }
}
