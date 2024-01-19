import 'package:crea_chess/package/firebase/export.dart';
import 'package:flutter/material.dart';

const avatarNames = [
  'antoine',
  'cassandra',
  'catherine',
  'charles',
  'claude',
  'gabrielle',
  'hugo',
  'ines',
  'lea',
  'leo',
  'lucas',
  'madeleine',
  'maeva',
  'manu',
  'mathis',
  'nathan',
  'nick',
  'orion',
  'ricardo',
  'victor',
  'yannick',
];

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    required this.photo,
    this.backgroundColor,
    this.radius,
    super.key,
  });

  static Widget fromId({
    required String userId,
    Color? backgroundColor,
    double? radius,
  }) {
    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: userId),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return const CircularProgressIndicator();
        return UserPhoto(
          photo: user.photo,
          backgroundColor: backgroundColor,
          radius: radius,
        );
      },
    );
  }

  final String? photo;
  final Color? backgroundColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      backgroundImage: _getPhotoAsset(photo),
      radius: radius,
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
