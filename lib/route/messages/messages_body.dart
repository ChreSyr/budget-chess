import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessagesBody extends MainRouteBody {
  const MessagesBody({super.key})
      : super(
          id: 'messages',
          icon: Icons.forum,
        );

  @override
  String getTitle(AppLocalizations l10n) {
    return l10n.messages;
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Messages page'));
  }
}
