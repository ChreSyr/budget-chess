import 'dart:math';

import 'package:crea_chess/package/atomic_design/color.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    required this.photo,
    this.backgroundColor,
    this.radius = 20,
    this.isConnected,
    this.onTap,
    super.key,
  });

  static Widget fromId({
    required String userId,
    Color? backgroundColor,
    double radius = 20,
    bool? showConnectedIndicator,
    void Function()? onTap,
  }) {
    return StreamBuilder<UserModel?>(
      stream: userCRUD.stream(documentId: userId),
      builder: (context, snapshot) => UserPhoto(
        photo: snapshot.data?.photo,
        backgroundColor: backgroundColor,
        radius: radius,
        isConnected: showConnectedIndicator == true &&
            snapshot.data?.isConnected == true,
        onTap: onTap,
      ),
    );
  }

  final String? photo;
  final Color? backgroundColor;
  final double radius;
  final bool? isConnected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final avatar = SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: CircleAvatar(
        backgroundColor: (photo ?? '').isEmpty
            ? Colors.red[100]
            : backgroundColor ?? Colors.transparent,
        backgroundImage: _getPhotoAsset(photo),
        radius: radius,
      ),
    );

    final stack = isConnected == true
        ? Stack(
            children: [
              avatar,
              ConnectedIndicator(
                size: sqrt(radius) * 4,
                backgroundColor: backgroundColor,
              ),
            ],
          )
        : avatar;

    return onTap == null
        ? stack
        : GestureDetector(
            onTap: onTap,
            child: stack,
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

class ConnectedIndicator extends StatelessWidget {
  const ConnectedIndicator({
    required this.size,
    this.backgroundColor,
    super.key,
  });

  static const ConnectedIndicator small =
      ConnectedIndicator(size: CCSize.large);

  final double size;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -size / 6,
      bottom: -size / 6,
      child: SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor ?? context.colorScheme.background,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: size / 3,
            ),
          ),
        ),
      ),
    );
  }
}
