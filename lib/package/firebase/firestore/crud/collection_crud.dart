// Abstract CRUD class
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CollectionCRUD<T> {
  CollectionCRUD({required this.collectionName}) {
    _collection =
        FirebaseFirestore.instance.collection(collectionName).withConverter<T?>(
              toFirestore: modelToJson,
              fromFirestore: jsonToModel,
            );
  }

  final String collectionName;
  late final CollectionReference<T?> _collection;

  T? jsonToModel(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  );
  Map<String, Object?> modelToJson(T? data, SetOptions? _);

  Future<void> create({required T data, String? documentId}) async {
    await _collection.doc(documentId).set(data);
  }

  Future<T?> read({required String documentId}) async {
    return _collection.doc(documentId).get().then(
          (snapshot) => snapshot.data(),
        );
  }

  Future<Iterable<T>> readFiltered({
    required Query<T?> Function(CollectionReference<T?>) filter,
  }) {
    return filter(_collection).get().then(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).whereType<T>(),
        );
  }

  Stream<T?> stream({required String documentId}) {
    final streamController = StreamController<T?>();

    if (documentId.isNotEmpty) {
      _collection.doc(documentId).snapshots().listen((snapshot) {
        streamController.add(snapshot.data());
      });
    }

    return streamController.stream;
  }

  Stream<Iterable<T>> streamAll() {
    return _collection.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).whereType<T>(),
        );
  }

  Stream<Iterable<T>> streamFiltered({
    required Query<T?> Function(CollectionReference<T?>) filter,
  }) {
    return filter(_collection).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).whereType<T>(),
        );
  }

  Future<void> update({required String documentId, required T data}) async {
    await _collection.doc(documentId).update(modelToJson(data, null));
  }

  Future<void> delete({required String documentId}) async {
    await _collection.doc(documentId).delete();
  }
}
