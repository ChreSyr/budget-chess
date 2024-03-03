import 'package:crea_chess/package/firebase/export.dart';
import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    required this.photo,
    this.backgroundColor,
    this.radius,
    this.onTap,
    super.key,
  });

  static Widget fromId({
    required String userId,
    Color? backgroundColor,
    double? radius,
    void Function()? onTap,
  }) {
    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: userId),
      builder: (context, snapshot) => UserPhoto(
        photo: snapshot.data?.photo,
        backgroundColor: backgroundColor,
        radius: radius,
        onTap: onTap,
      ),
    );
  }

  final String? photo;
  final Color? backgroundColor;
  final double? radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      backgroundColor: (photo ?? '').isEmpty
          ? Colors.red[100]
          : backgroundColor ?? Colors.transparent,
      backgroundImage: _getPhotoAsset(photo),
      radius: radius,
    );
    return onTap == null
        ? avatar
        : GestureDetector(
            onTap: onTap,
            child: avatar,
          );
  }
}

ImageProvider<Object>? _getPhotoAsset(String? photo) {
  if (photo == null || photo.isEmpty) {
    return null;
  } else if (photo.startsWith('avatar-')) {
    return AssetImage('assets/${photo.replaceAll('-', '/')}.jpg');
  } else {
    return NetworkImage(photo);
  }
}
