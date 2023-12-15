import 'package:crea_chess/package/atomic_design/padding.dart';
import 'package:crea_chess/package/l10n/l10n.dart';
import 'package:crea_chess/route/route_body.dart';
import 'package:flutter/material.dart';

class RouteScaffold extends StatelessWidget {
  const RouteScaffold({
    required this.body,
    super.key,
  });

  final RouteBody body;

  @override
  Widget build(BuildContext context) {
    Widget padd(
      Widget child, {
      required bool centered,
      required bool padded,
      required bool scrolled,
    }) {
      final temp1 = scrolled ? SingleChildScrollView(child: body) : body;
      final temp2 = centered ? Center(child: temp1) : temp1;
      final temp3 = padded ? CCPadding.horizontalLarge(child: temp2) : temp2;
      return temp3;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(body.getTitle(context.l10n)),
        actions: body.getActions(context),
      ),
      body: padd(
        body,
        centered: body.centered,
        padded: body.centered,
        scrolled: body.scrolled,
      ),
    );
  }
}
