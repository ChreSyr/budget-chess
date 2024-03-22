import 'package:crea_chess/package/atomic_design/modal/modal.dart';
import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:crea_chess/package/firebase/firestore/user/user_crud.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const bannerNames = [
  'clarky_pngtree',
  'deepj_pngtree',
  'wart_pngtree',
  'clack_pxfuel',
  'molg_pngtree',
  'gamble_pngtree',
  'hander_ftcdn',
  'pur_wallpaperflare',
  'sandwitch_pngtree',
  'gold_pinimg',
];

class UserBanner extends StatelessWidget {
  const UserBanner(
    this.banner, {
    this.editable = false,
    super.key,
  });

  final String? banner;
  final bool editable;

  static const empty = ColoredBox(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: editable ? () => showBannerModal(context) : null,
      child: AspectRatio(
        aspectRatio: 3,
        child: banner == null
            ? empty
            : Image.asset(
                'assets/banner/$banner.jpg',
                fit: BoxFit.fitWidth,
                errorBuilder: (a, b, c) => empty,
              ),
      ),
    );
  }
}

void showBannerModal(BuildContext context) {
  Modal.show(
    context: context,
    sections: [
      GridView.count(
        shrinkWrap: true,
        childAspectRatio: 3,
        crossAxisCount: 2,
        crossAxisSpacing: CCSize.large,
        mainAxisSpacing: CCSize.large,
        children: bannerNames
            .map(
              (e) => GestureDetector(
                onTap: () {
                  userCRUD.userCubit.setBanner(banner: e);
                  context.pop();
                },
                child: UserBanner(e),
              ),
            )
            .toList(),
      ),
    ],
  );
}
