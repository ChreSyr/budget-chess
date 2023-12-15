import 'package:flutter/material.dart';

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
  const UserBanner(this.banner, {super.key});

  final String? banner;

  static const empty = ColoredBox(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: banner == null
          ? empty
          : Image.asset(
              'assets/banner/$banner.jpg',
              fit: BoxFit.fitWidth,
              errorBuilder: (a, b, c) => empty,
            ),
    );
  }
}
