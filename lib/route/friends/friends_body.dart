import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendsBody extends MainRouteBody {
  const FriendsBody({super.key})
      : super(
          id: 'friends',
          icon: Icons.people,
        );

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.friends;
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Friends page'));
  }
}
