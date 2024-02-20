import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:crea_chess/package/preferences/preferences_cubit.dart';
import 'package:crea_chess/package/preferences/preferences_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    void Function()? onTap,
  }) {
    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: userId),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final photo = UserPhoto(
          photo: user?.photo,
          backgroundColor: backgroundColor,
          radius: radius,
        );
        return onTap == null
            ? photo
            : GestureDetector(
                onTap: onTap,
                child: photo,
              );
      },
    );
  }

  final String? photo;
  final Color? backgroundColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: CCColor.background(context),
            width: CCSize.xsmall), // Définir la bordure blanche
      ),
      child: CircleAvatar(
        backgroundColor: backgroundColor ?? Colors.transparent,
        backgroundImage: _getPhotoAsset(photo),
        radius: radius,
      ),
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
