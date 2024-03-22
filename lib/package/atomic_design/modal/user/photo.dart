import 'dart:io';

import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/atomic_design/widget/gap.dart';
import 'package:crea_chess/package/firebase/export.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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

void showAvatarModal(
  BuildContext context,
  void Function(String avatarName) onSelect,
) {
  Modal.show(
    context: context,
    // isScrollControlled: true,
    sections: [
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                spacing: CCSize.medium,
                runSpacing: CCSize.medium,
                children: avatarNames
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          onSelect(e);
                          context.pop();
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/avatar/$e.jpg'),
                          radius: CCSize.xlarge,
                        ),
                      ),
                    )
                    .toList(),
              ),
              CCGap.large,
            ],
          ),
        ),
      ),
    ],
  );
}

Future<Reference?> uploadProfilePhoto(ImageSource source, String userId) async {
  final pickedFile = await ImagePicker().pickImage(source: source);

  if (pickedFile == null) return null;

  final photoRef = FirebaseStorage.instance.getUserPhotoRef(userId);
  await photoRef.putFile(File(pickedFile.path));
  return photoRef;
}
