import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ModelConverter<T> {
  T fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? _,
  );

  Map<String, dynamic> toFirestore(T data, SetOptions? _);

  T emptyModel();
}
