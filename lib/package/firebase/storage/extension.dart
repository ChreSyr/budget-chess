import 'package:firebase_storage/firebase_storage.dart';

extension FirebaseStorageExtension on FirebaseStorage {
  Reference getUserPhotoRef(String userId) {
    return FirebaseStorage.instance
        .ref()
        .child('image')
        .child('userPhoto')
        .child(userId);
  }
}
