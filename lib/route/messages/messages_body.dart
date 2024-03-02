import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessagesBody extends MainRouteBody {
  const MessagesBody({super.key});

  static final MainRouteData data = MainRouteData(
    id: 'messages',
    icon: Icons.forum,
    getTitle: (l10n) => l10n.messages,
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
