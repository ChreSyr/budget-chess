import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<Widget> getEmergencyAppBarActions(BuildContext context) => [
      IconButton(
        onPressed: () => context.push('/settings'),
        icon: const Icon(Icons.settings),
      ),
    ];
